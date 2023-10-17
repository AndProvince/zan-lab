//
//  UserDefaultsWorker.swift
//  Zan-Lab
//
//  Created by Андрей on 27.09.2023.
//

import Foundation

class UserDefaultsWorker {
    static let shared = UserDefaultsWorker()
    
    private static let KEY_ACCESS_TOKEN = "auth_token"
    private static let KEY_ACCESS_TOKEN_EXPIRE = "expires_in"
    private static let KEY_REFRESH_TOKEN = "refresh_token"
    
    func saveAuthTokens(tokens: TokensInfo) {
        let accessTokenExpire: Int64 = tokens.accessTokenExpire + Int64(Date().timeIntervalSince1970)
        
        let defaults = UserDefaults.standard
        defaults.set(tokens.accessToken, forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN)
        defaults.set(accessTokenExpire, forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN_EXPIRE)
        defaults.set(tokens.refreshToken, forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN)
    }
    
    func getAccessToken() -> TokenInfo {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN) as? String ?? ""
        let expiresAt = defaults.object(forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN_EXPIRE) as? Int64 ?? 0
        return TokenInfo(token: token, expiresAt: expiresAt)
    }
    
    func getRefreshToken() -> TokenInfo {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN) as? String ?? ""
        let expiresAt = Int64(0) // или Int64.max поле не используется в дальнейшем
        return TokenInfo(token: token, expiresAt: expiresAt)
    }
    
    func haveAuthTokens() -> Bool {
        return !getAccessToken().token.isEmpty && !getRefreshToken().token.isEmpty
    }
    
    func dropTokens() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN)
        defaults.set(0 as Int64, forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN_EXPIRE)
        defaults.set("", forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN)
    }
}
