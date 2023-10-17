//
//  AuthBody.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

struct OtpBody: Codable {
    let mobile: String
}

struct RegBody: Codable {
    let mobile: String
    let password: String
    let otpCode: String
}

struct AuthBody: Codable {
    let username: String
    let password: String
    //let grant_type: String
    //let scope: String
    
    func getPostData() -> Data {
        let parameters = "grant_type=password&username=\(username)&password=\(password)&scope=openid"
        let postData =  parameters.data(using: .utf8)!
        return postData
    }
}
