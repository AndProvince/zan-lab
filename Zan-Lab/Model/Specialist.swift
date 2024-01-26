//
//  Specialist.swift
//  Zan-Lab
//
//  Created by Андрей on 03.10.2023.
//

import Foundation

struct Specialist: Codable {
    let person: User
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
    
    func getWorkDuration() -> String {
        if let index = workExperienceDuration.firstIndex(of: "Y") {
            let years =  Int(workExperienceDuration.prefix(upTo: index))!
            return "\(years) \(self.getYearWord(numberOfYears: years))"
        } else {
            return ""
        }
    }
    
    func getYearWord(numberOfYears: Int) -> String {
        let remainder10 = numberOfYears % 10
        let remainder100 = numberOfYears % 100

        if remainder10 == 1 && remainder100 != 11 {
            return "год"
        } else if (remainder10 >= 2 && remainder10 <= 4) && (remainder100 < 10 || remainder100 >= 20) {
            return "года"
        } else {
            return "лет"
        }
    }
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
