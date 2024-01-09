//
//  APIResponse.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import Foundation

struct APIResponse: Codable, Hashable {
    
    var success: Bool
    var historical: Bool
    var base: String
    var date: String
    var rates: [String: Decimal]
    
}
