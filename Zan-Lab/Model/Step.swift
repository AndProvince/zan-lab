//
//  Step.swift
//  Zan-Lab
//
//  Created by Андрей on 06.10.2023.
//

import Foundation

struct Step: Codable {
    let id: Int
    let stepNameRu: String
    let stepHintRu: String
    let stepNameKz: String
    let stepHintKz: String
    let descriptionRu: String
    let descriptionKz: String
    let fileId: String
}
