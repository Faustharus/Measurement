//
//  APIResponse.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import Foundation

//fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct APIResponse: Codable, Hashable {
    
    var success: Bool
    var base: String
    var date: String
    var rates: [String: Decimal] //Rates
    
    var formattedDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? Date()
    }
    
//    var releaseDate: String {
//        return relativeDateFormatter.localizedString(for: date, relativeTo: Date())
//    }
    
}
