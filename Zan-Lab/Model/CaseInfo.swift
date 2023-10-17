//
//  CaseInfo.swift
//  Zan-Lab
//
//  Created by Андрей on 28.09.2023.
//

import Foundation

struct CaseInfo: Codable {
    let caseInfo: Case
    let cnt: Int
}

struct Case: Codable {
    let id: Int
    let caseNameRu: String
    let caseNameKz: String
    let files: [File]
}

struct File: Codable {
    let id: Int
    let fileId: String
    
    func getImageURL() -> URL {
        return URL(string: "\(Endpoint.getFile.absoluteURL)\(fileId)/download")!
    }
}
