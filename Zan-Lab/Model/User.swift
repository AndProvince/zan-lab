//
//  User.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

struct User: Codable {
    var id: Int
    var lastName: String?
    var firstName: String?
    var mobile: String
    var email: String?
    var contacts: [String]?
    var about: String?
    var photoFileId: String?
    var locationRefKeyId: Int?
    var userId: Int?
    var pendingEmails: [String]?
    
    func getImageURL() -> URL {
        return URL(string: "\(Endpoint.getFile.absoluteURL)\(photoFileId ?? "")/download")!
    }
    
    func getName() -> String {
        if lastName!.isEmpty || firstName!.isEmpty {
            return "User#\(id)"
        } else {
            return "\(lastName!) \(firstName!)"
        }
    }
    
    func getMobile() -> String {
        return "+\(mobile)"
    }
    
    func isEmail() -> Bool {
        return ((email?.isEmpty) != nil)
    }
}

//struct AuthResult: Codable {
//    let accessToken: String
//    let accessTokenExpire: Int64
//    let refreshToken: String
//    let refreshTokenExpire: Int64
//    
//    let scope: String
//    let idToken: String
//    let tokenType: String
//
//    enum CodingKeys: String, CodingKey {
//        case accessToken = "access_token"
//        case accessTokenExpire = "auth_token_expire"
//        case refreshToken = "refresh_token"
//        case refreshTokenExpire = "refresh_token_expire"
//
//        case scope = "scope"
//        case idToken = "id_token"
//        case tokenType = "token_type"
//    }
//
//    func getTokensInfo() -> TokensInfo {
//            return TokensInfo(accessToken: accessToken,
//                              accessTokenExpire: accessTokenExpire,
//                              refreshToken: refreshToken
//            )
//        }
//}
