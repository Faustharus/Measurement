//
//  APIResponse.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct APIResponse: Codable, Hashable {
    
    var success: Bool
    var base: String
    var date: Date
    var rates: Rates
    
    var releaseDate: String {
        return relativeDateFormatter.localizedString(for: date, relativeTo: Date())
    }
    
}
