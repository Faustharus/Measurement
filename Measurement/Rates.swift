//
//  Rates.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import Foundation

struct Rates: Codable, Equatable, Hashable {
    var gbp: Double
    var jpy: Double
    var eur: Double
    var cny: Double
    var cad: Double
    var aud: Double
    var aed: Double
    
    enum CodingKeys: String, CodingKey {
        case gbp = "GBP"
        case jpy = "JPY"
        case eur = "EUR"
        case cny = "CNY"
        case cad = "CAD"
        case aud = "AUD"
        case aed = "AED"
    }
}

extension Rates {
    
//    static var localJSONData: Rates {
//        let previewDataURL = Bundle.main.url(forResource: "exchange", withExtension: "json")!
//        guard let data = try? Data(contentsOf: previewDataURL) else {
//            return .init(gbp: 0.87, jpy: 1101.45, eur: 1.04, cny: 23.49, cad: 1.12, aud: 1.19, aed: 10134.39)
//        }
//        
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        
//        let apiResponse = try! decoder.decode(APIResponse.self, from: data)
//        return apiResponse.rates
//    }
    
    //static let dummyNews: Rates = .init(gbp: 0.87, jpy: 1101.45, eur: 1.04, cny: 23.49, cad: 1.12, aud: 1.19, aed: 10134.39)
    
}
