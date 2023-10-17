//
//  Refs.swift
//  Zan-Lab
//
//  Created by Андрей on 09.10.2023.
//

import Foundation

struct Ref: Codable {
    let recordId: Int
    let refKindCodeName: String
    let codeName: String
    let nameRu: String
    let nameKz: String
    let actual: Bool
}

struct RefValue: Codable {
    let refKeyId: Int
    let refKeyCodeName: String
    let valueRu: String
    let valueKz: String
    let shortValueRu: String
    let shortValueKz: String
}

struct ResponseFor<T: Codable>: Codable {
    let content: T
    
    let pageable: Pegeable
    let last: Bool
    let totalPages: Int
    let totalElements: Int
    let first: Bool
    let size: Int
    let number: Int
    let sort: [String]
    let numberOfElements: Int
    let empty: Bool
}
