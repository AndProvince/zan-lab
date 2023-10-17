//
//  Specialist.swift
//  Zan-Lab
//
//  Created by Андрей on 03.10.2023.
//

import Foundation

struct Specialist: Codable {
    let person: Person
    let personLegals: [Legal]
    let totalSpec: Int
    let totalArea: Int
    let totalOffer: Int
}

struct Person: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let mobile: String
    let email: String
    let contacts: [String]
    let locationRefKeyId: Int?
    let photoFileId: String?
    let userId: Int
    
    func getImageURL() -> URL {
        return URL(string: "\(Endpoint.getFile.absoluteURL)\(photoFileId ?? "")/download")!
    }
}

struct Legal: Codable {
    let id: Int
    let license: String
    let specializationRefKeyId: Int
    let careerStartDate: String
    let activityAreasWithOffers: [Area]
    let workExperienceDuration: String
}

struct Area: Codable {
    let activityAreaId: Int
    let offerRefKeyIds: [Int]
}

struct Pegeable: Codable {
    let sort: [String]
    let pageNumber: Int
    let offset: Int
    let pageSize: Int
    let unpaged: Bool
    let paged: Bool
}

struct SearchBody: Codable {
    let groups: [String]
    let columnList: String
}
