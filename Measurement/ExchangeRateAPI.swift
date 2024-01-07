//
//  ExchangeRateAPI.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import Foundation

struct ExchangeRateAPI {
    
    static let shared = ExchangeRateAPI()
    private init() {}
    
    private let apiKey = RateAPIKey.apiKey
    private let session = URLSession.shared
    private let decoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    
    
}
