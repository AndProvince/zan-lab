//
//  utils.swift
//  Zan-Lab
//
//  Created by  Andrey on 16.01.2024.
//

import Foundation

func FormatByMask(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex

    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])

            // move numbers iterator to the next index
            index = numbers.index(after: index)

        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}

func UnFormatByMask(with mask: String, phone: String) -> String {
    var result = ""
    
    for index in phone.indices {
        if mask[index] == "X" {
            result.append(phone[index])
        }
    }
    
    return result
}

func SaveRomanLettersAndDigits(word: String) -> String {
    let result = word.replacingOccurrences(of: "[^A-Za-z0-9]", with: "", options: .regularExpression)
    
    return result
}

func IsNeedNumber(word: String) -> Bool {
    let result = word.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    
    return result.isEmpty
}

func IsNeedUpper(word: String) -> Bool {
    let result = word.replacingOccurrences(of: "[^A-Z]", with: "", options: .regularExpression)
    
    return result.isEmpty
}

func IsNeedLower(word: String) -> Bool {
    let result = word.replacingOccurrences(of: "[^a-z]", with: "", options: .regularExpression)
    
    return result.isEmpty
}
