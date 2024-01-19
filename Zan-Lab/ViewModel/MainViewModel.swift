//
//  MainViewModel.swift
//  Zan-Lab
//
//  Created by Андрей on 28.09.2023.
//

import Foundation
import UIKit

class MainViewModel: ObservableObject {
    
    @Published var loginPending = false
    @Published var registerPending = false
    
    @Published var userLogined = false
    
    @Published var showProfile = false
    @Published var showEditProfile = false
    
    
    @Published var topCases: [CaseInfo] = []
    @Published var specialists: [Specialist] = []
    @Published var allCases: [Case] = []
    @Published var allSteps: [Step] = []
    @Published var allLocations: [RefValue] = []
    @Published var allSpecializations: [RefValue] = []
    
    @Published var user: User?
    
    @Published var messageTitle = ""
    @Published var messageText = ""
    
    //@Published var alert: IdentifiableAlert?
    
    init() {
        self.getUser()
        
        self.getSpecialists()
        self.getAllCases()
        self.getAllSteps()
        
        self.getLocations()
        self.getSpecializations()
    }
    
    func logout() {
        //UserDefaultsWorker.shared.dropTokens()
        Requester.shared.dropTokens()
        self.userLogined = false
    }
    
    func doLogin(login: String, password: String) {
        print("login called")
        Requester.shared.login(authBody: AuthBody(username: login, password: password)) { result in
            //print("login result: \(result)")
            switch result {
            case .success(_):
                print("login complited")
                self.getUser()
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func getUser() {
        print("get user called")
        Requester.shared.getUser() { result in
            switch result {
            case .success(let answer):
                self.user = answer
                print("user loaded")
                self.userLogined = true
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func putUser() {
        print("put user called")
        Requester.shared.putUser(user: self.user!) { result in
            switch result {
            case .success(_):
                print("user uploaded")
            case .serverError(_):
                // to do alert
                print("Server error, but if status code is 200 - it is ok")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func saveProfilePhoto(image: UIImage) {
        print("save Profile Photo called")
        Requester.shared.savePhoto(image: image) { result in
            print(result)
            switch result {
            case .success(let photoName):
                print("photo uploaded")
                print(photoName)
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
        let data = image.jpegData(compressionQuality: 1)
        print(data)
    }
    
    func sendOtp(login: String) {
        print("send OTP called")
        Requester.shared.sendOtpCode(otpBody: OtpBody(mobile: login)) { result in
            print("send OTP result: \(result)")
            switch result {
            case .success(let answer):
                self.registerPending = true
                print(answer)
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func register(login: String, password: String, otpCode: String) {
        print("register called")
        Requester.shared.register(regBody: RegBody(mobile: login, password: password, otpCode: otpCode)) { [self] result in
            print("register response: \(result)")
            switch result {
            case .success(_):
                //self.messageTitle = "Успешная регистрация"
                //self.messageText = "Перейти на страницу входа?"
                self.loginPending = true
                
                print("register successfull")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
            
        }
    }
    
    func getTopCases() {
        print("get top cases called")
        Requester.shared.getCases() { result in
            switch result {
            case .success(let answer):
                self.topCases = answer
                print("get top cases loaded")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func getAllCases() {
        print("get all cases called")
        Requester.shared.getAllCases() { result in
            switch result {
            case .success(let answer):
                self.allCases = answer.content
                print("get all cases loaded")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func getAllSteps() {
        print("get all steps called")
        Requester.shared.getAllSteps() { result in
            switch result {
            case .success(let answer):
                self.allSteps = answer
                print("get all steps loaded")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func getSpecialists() {
        print("get specialists called")
        Requester.shared.getSpecialists(searchBody: SearchBody(groups: [], columnList: "*")) { result in
            //print(result)
            switch result {
            case .success(let answer):
                self.specialists = answer.content
                print("specialists loaded")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func getLocations() {
        print("get locations called")
        Requester.shared.getLocations() { result in
            //print(result)
            switch result {
            case .success(let answer):
                self.allLocations = answer.content
                print("locations loaded")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    
    func getSpecializations() {
        print("get specializations called")
        Requester.shared.getSpecializations() { result in
            //print(result)
            switch result {
            case .success(let answer):
                self.allSpecializations = answer.content
                print("locations loaded")
            case .serverError(_):
                // to do alert
                print("Server error")
            case .authError(_):
                // to do alert
                self.logout()
                print("Auth error")
            case .networkError(_):
                // to do alert
                print("Network error")
            }
        }
    }
    

}
