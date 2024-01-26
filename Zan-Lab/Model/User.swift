//
//  User.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

struct User: Codable, Hashable {
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
        if let lname = lastName, let fname = firstName, !lname.isEmpty {
            return "\(lname) \(fname)"
        } else {
            return "User#\(id)"
        }
    }
    
    func getMobile() -> String {
        let mask = "+X (XXX) XXX-XX-XX"
        return FormatByMask(with: mask, phone: mobile)
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
