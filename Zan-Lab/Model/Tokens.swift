//
//  Tokens.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

struct TokensInfo: Codable {
    let accessToken: String
    let accessTokenExpire: Int64
    let refreshToken: String
    
    let scope: String = ""
    let idToken: String = ""
    let tokenType: String = ""
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenExpire = "expires_in"
        case refreshToken = "refresh_token"
        
        case scope = "scope"
        case idToken = "id_token"
        case tokenType = "token_type"
    }
    
    func getTokensInfo() -> TokensInfo {
            return TokensInfo(accessToken: accessToken,
                              accessTokenExpire: accessTokenExpire,
                              refreshToken: refreshToken
            )
        }
}

struct TokenInfo {
    let token: String
    let expiresAt: Int64
}
