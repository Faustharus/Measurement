//
//  Currencies.swift
//  Measurement
//
//  Created by Damien Chailloleau on 09/01/2024.
//

import Foundation

// MARK: - Currency
struct Currencies: Codable, Hashable, Equatable {
    let continent: String
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable, Hashable, Equatable {
    let acronym, name: String
}
