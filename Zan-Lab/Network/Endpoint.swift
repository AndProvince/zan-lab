//
//  Endpoint.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

// перечисление для взаимодействия с сервером
enum Endpoint {
    
    //static let srvURL: String = "https://zanpro-tst.alseco.kz"
    static let srvURL: String = "https://zanpro-preprod.alseco.kz"
    
    case sendOtpCode
    case register
    case login
    case refreshTokens
    case getUser
    case savePhoto
    case getCases
    case getAllCases
    case getAllSteps
    case getSpecialists
    case getFile
    case getLocations
    case getSpecializations
    
    func path() -> String {
        switch self {
        case .sendOtpCode:
            return "/api/zanpro-api/api/v1/auth/verify-and-send-otp"
        case .register:
            return "/api/zanpro-api/api/v1/auth/sign-up"
        case .login:
            return "/oauth2/token"
        case .refreshTokens:
            return "/oauth2/token"
        case .getUser:
            return "/api/zanpro-api/api/v1/person"
        case .savePhoto:
            return "/api/zanpro-api/api/v1/person/photo"
        case .getCases:
            return "/api/zanpro-api/api/v1/cases-top/search"
        case .getAllCases:
            return "/api/zanpro-api/api/v1/cases/search/list"
        case .getAllSteps:
            return "/api/zanpro-api/api/v1/steps/search"
        case .getSpecialists:
            return "/api/zanpro-api/api/v1/person-legal/search/group/profile?page=0&size=1000"
        case .getFile:
            return "/api/zanpro-files/internal/v1/file/"
        case .getLocations:
            return "/api/zanpro-refs/api/v1/refs/locations/ref-values?size=1000"
        case .getSpecializations:
            return "/api/zanpro-refs/api/v1/refs/specializations/ref-values?size=1000"
        }
    }
    
    var absoluteURL: URL {
        URL(string: Endpoint.srvURL + self.path())!
    }
}
