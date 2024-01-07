//
//  Rates.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import Foundation

struct Rates: Codable, Equatable, Hashable {
    var signatureRate: [String: Double]
}

extension Rates {
    
    static var localJSONData: Rates {
        let previewDataURL = Bundle.main.url(forResource: "exchange", withExtension: "json")!
        guard let data = try? Data(contentsOf: previewDataURL) else {
            return Rates.init(signatureRate: ["" : 0.0])
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! decoder.decode(APIResponse.self, from: data)
        return apiResponse.rates
    }
    
}
