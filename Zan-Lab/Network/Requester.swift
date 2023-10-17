//
//  Requester.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    func isAuth() -> Bool {
        return Errors.isAuthError(err: message)
    }
}

// перечисление типов ответа от сервера
enum Result<T> {
    case success(_ response: T)
    case serverError(_ err: ErrorResponse)
    case authError(_ err: ErrorResponse)
    case networkError(_ err: String)
}


class Requester {
    static let shared = Requester()
    
    static private let ACCESS_TOKEN_LIFE_THRESGOLD_SECONDS: Int64 = 10
    
    static private let WSO2IS_CLIENT_ID = "AZoH1U87FFfUFlVaWAUjRBopeP0a"
    static private let WSO2IS_SECRET_ID = "77BdQqBUwP7ulOURZGvaa2X68b9b"
    
    // для сохранения тела исходного запроса
    // в случае необходимости обновления Access токена
    private var requestData: Data = Data()
    
    private var accessToken = UserDefaultsWorker.shared.getAccessToken()
    private var refreshToken = UserDefaultsWorker.shared.getRefreshToken()
    
    private init() {}
    
    private func onTokensRefreshed(tokens: TokensInfo) {
        // сохранить обновленные токены
        UserDefaultsWorker.shared.saveAuthTokens(tokens: tokens)
        
        // обновить токены в реквестере
        accessToken = UserDefaultsWorker.shared.getAccessToken()
        refreshToken = UserDefaultsWorker.shared.getRefreshToken()
    }
    
    // сброс текущих токенов - на случай выхода из системы
    func dropTokens() {
        UserDefaultsWorker.shared.dropTokens()
        accessToken = TokenInfo(token: "", expiresAt: 0)
        refreshToken = TokenInfo(token: "", expiresAt: 0)
    }
    
    // универсальный метод создания запросов
    private func formRequest(url: URL,
                             data: Data = Data(),
                             method: String = "POST",
                             contentType: String = "application/json",
                             // флаг формирования запроса на обновление токенов
                             refreshTokens: Bool = false,
                             // флаг формирования запроса на вход в систему = получение токенов
                             logining: Bool = false,
                             noAuth: Bool = false) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // авторизация в запросе
        if logining {
            // устанавливаем Base авторизацию для входа в систему
            let loginString = String(format: "%@:%@", Requester.WSO2IS_CLIENT_ID, Requester.WSO2IS_SECRET_ID)
            let loginData = loginString.data(using: String.Encoding.utf8)
            let base64LoginString = loginData?.base64EncodedString()
            request.addValue("Basic \(base64LoginString ?? "")", forHTTPHeaderField: "Authorization")
        } else if !noAuth {
            // для всех остальных запросов требующих авторизацию подключаем access token
            request.addValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        }
        
        // тип данных в зарпосе
        if logining || refreshTokens {
            // устанавливает Content-Type для запросов к WSO
            let authContentType = "application/x-www-form-urlencoded"
            request.setValue(authContentType, forHTTPHeaderField: "Content-Type")
        } else {
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        // тело запроса
        if refreshTokens {
            // сохраняем изначальное тело запроса
            requestData = data
            // формирует тело запроса на обновление access токена
            let parameters = "grant_type=refresh_token&client_id=\(Requester.WSO2IS_CLIENT_ID)&refresh_token=\(refreshToken.token)"
            let postData =  parameters.data(using: .utf8)
            request.httpBody = postData
        } else {
            request.httpBody = data
        }
        
        return request
    }
    
    private func formRefreshTokensRequest() -> URLRequest {
        return formRequest(url: Endpoint.refreshTokens.absoluteURL, refreshTokens: true)
    }
    
    // метод заменяет токен доступа в заголовке авторизации на текущий
    private func renewAuthHeader(request: URLRequest) -> URLRequest {
        var newRequest = request
        let contentType = "application/json"
        newRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        newRequest.setValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        
        // возвращаем изначальное тело запроса после обновления токенов
        newRequest.httpBody = requestData
        return newRequest
    }
    
    // проверяка нужно ли обновлять токены
    private var needReAuth: Bool {
        let current = Int64(Date().timeIntervalSince1970)
        let expires = accessToken.expiresAt
        return current + Requester.ACCESS_TOKEN_LIFE_THRESGOLD_SECONDS > expires
    }
    
    // общий метод для запросов требующих авторизацию
    // проверяет нужно ли обновлять токены перед запросом
    // или просто выполнить запрос
    func request<T: Decodable>(request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        if (needReAuth && !refreshToken.token.isEmpty) {
            authAndDoRequest(request: request, onResult: onResult)
        } else {
            doRequest(request: request, onResult: onResult)
        }
    }
    
    // метод формирует и выполняет запрос на обновление токенов
    // после выполняет запрос через doRequest
    func authAndDoRequest<T: Decodable>(request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        let refreshRequest = formRefreshTokensRequest()
        let task = URLSession.shared.dataTask(with: refreshRequest) { [self] (data, response, error) -> Void in
            if let error = error {
                DispatchQueue.main.async {
                    onResult(.networkError(error.localizedDescription))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                // не должно выполняться никуда
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_CONVERTING_TO_HTTP_RESPONSE)))
                }
                return
            }
            guard let data = data else {
                // не должно выполняться никогда
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }
            
            if httpResponse.isSuccessful() {
                do {
                    let response = try JSONDecoder().decode(TokensInfo.self, from: data)
                    onTokensRefreshed(tokens: response)
                    let newRequest = renewAuthHeader(request: request)
                    doRequest(request: newRequest, onResult: onResult)
                    return
                } catch {
                    DispatchQueue.main.async {
                        onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_RESPONSE)))
                    }
                    return
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        onResult(.authError(errorResponse))
                    }
                    return
                } catch {
                    DispatchQueue.main.async {
                        onResult(.authError(ErrorResponse(code: 0, message: error.localizedDescription)))
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    // выполняет зарпос без проверки авторизации
    func doRequest<T: Decodable>(request: URLRequest, onResult: @escaping (Result<T>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                DispatchQueue.main.async {
                    onResult(.networkError(error.localizedDescription))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                // не должно выполняться никуда
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_CONVERTING_TO_HTTP_RESPONSE)))
                }
                return
            }
            guard let data = data else {
                // не должно выполняться никогда
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }
            //print(String(data: data, encoding: .utf8)!)
            print("Статус код \(httpResponse.statusCode)")
            
            if httpResponse.isSuccessful() {
                let responseBody: Result<T> = self.parseResponse(data: data)
                DispatchQueue.main.async {
                    onResult(responseBody)
                }
            } else {
                let responseBody: Result<T> = self.parseError(data: data)
                DispatchQueue.main.async {
                    onResult(responseBody)
                }
            }
        }
        task.resume()
    }
    
    // метод декодирует JSON-ответ в ожидаемый тип данных
    private func parseResponse<T: Decodable>(data: Data) -> Result<T> {
        do {
//            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//                print("data - \(JSONString)")
//            }
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return parseError(data: data)
        }
    }
    
    // метод декодирует полученную ошибку
    private func parseError<T>(data: Data) -> Result<T> {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            if errorResponse.isAuth() {
                return .authError(errorResponse)
            } else {
                return .serverError(errorResponse)
            }
        } catch {
            return .serverError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_ERROR_RESPONSE))
        }
    }
    
    private func handleAuthResponse(response: Result<TokensInfo>, onResult: @escaping (Result<TokensInfo>) -> Void) {
        if case .success(let newTokens) = response {
            self.onTokensRefreshed(tokens: newTokens.getTokensInfo())
        }
        onResult(response)
    }
    
    // отпарвка запроса на направление OTP
    func sendOtpCode(otpBody: OtpBody, onResult: @escaping (Result<Bool>) -> Void) {
        let url = Endpoint.sendOtpCode.absoluteURL
        let body = try! JSONEncoder().encode(otpBody)
        let request = formRequest(url: url, data: body, noAuth: true)
        self.request(request: request, onResult: onResult)
    }
    
    // отправка запроса на регистрацию пользователя
    func register(regBody: RegBody, onResult: @escaping (Result<Bool>) -> Void) {
        let url = Endpoint.register.absoluteURL
        let body = try! JSONEncoder().encode(regBody)
        let request = formRequest(url: url, data: body, noAuth: true)
        self.request(request: request, onResult: onResult)
//        self.doRequest(request: request) { [self] result in
//            self.handleAuthResponse(response: result, onResult: onResult)
//        }
    }
    
    // аутентификация пользователя
    func login(authBody: AuthBody, onResult: @escaping (Result<TokensInfo>) -> Void) {
        let url = Endpoint.login.absoluteURL
        let body = authBody.getPostData()
        let request = formRequest(url: url, data: body, logining: true)
        self.doRequest(request: request) { [self] result in
            self.handleAuthResponse(response: result, onResult: onResult)
        }
    }
    
    // получение частых ситуаций
    func getCases(onResult: @escaping (Result<[CaseInfo]>) -> Void) {
        let url = Endpoint.getCases.absoluteURL
        let request = formRequest(url: url, method: "GET", noAuth: true)
        self.request(request: request, onResult: onResult)
    }
    
    // получение всех ситуаций
    func getAllCases(onResult: @escaping (Result<ResponseFor<[Case]>>) -> Void) {
        let url = Endpoint.getAllCases.absoluteURL
        let request = formRequest(url: url, method: "GET", noAuth: true)
        self.request(request: request, onResult: onResult)
    }
    
    // получение всех этапов
    func getAllSteps(onResult: @escaping (Result<[Step]>) -> Void) {
        let url = Endpoint.getAllSteps.absoluteURL
        let request = formRequest(url: url, method: "GET", noAuth: true)
        self.request(request: request, onResult: onResult)
    }
    
    func getSpecialists(searchBody: SearchBody, onResult: @escaping (Result<ResponseFor<[Specialist]>>) -> Void) {
        let url = Endpoint.getSpecialists.absoluteURL
        let body = try! JSONEncoder().encode(searchBody)
        let request = formRequest(url: url, data: body, noAuth: true)
        self.doRequest(request: request, onResult: onResult)
    }
    
    func getUser(onResult: @escaping (Result<User>) -> Void) {
        let url = Endpoint.getUser.absoluteURL
        let request = formRequest(url: url, method: "GET")
        self.request(request: request, onResult: onResult)
    }
    
    func putUser(user: User, onResult: @escaping (Result<String>) -> Void) {
        let url = Endpoint.getUser.absoluteURL
        let body = try! JSONEncoder().encode(user)
        let request = formRequest(url: url, data: body, method: "PUT")
        self.request(request: request, onResult: onResult)
    }
    
    func getLocations(onResult: @escaping (Result<ResponseFor<[RefValue]>>) -> Void) {
        let url = Endpoint.getLocations.absoluteURL
        let request = formRequest(url: url, method: "GET", noAuth: true)
        self.doRequest(request: request, onResult: onResult)
    }
    
    func getSpecializations(onResult: @escaping (Result<ResponseFor<[RefValue]>>) -> Void) {
        let url = Endpoint.getSpecializations.absoluteURL
        let request = formRequest(url: url, method: "GET", noAuth: true)
        self.doRequest(request: request, onResult: onResult)
    }
}
