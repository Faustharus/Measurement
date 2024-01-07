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
    
    private func generateCurrencyExchange(from input: String) -> URL {
        let url = RateAPIURLConstant.rateAPILatest.appending("access_key=\(apiKey)&base=\(input)&symbols=USD,AUD,CAD,PLN,MXN")
        return URL(string: url)!
    }
    
    private func fetchRates(from url: URL) async throws -> Rates {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: "ExchangeRates", code: 1, userInfo: [NSLocalizedDescriptionKey : "Bad Response"])
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try decoder.decode(APIResponse.self, from: data)
            
            if apiResponse.success == true {
                return apiResponse.rates
            } else {
                throw NSError(domain: "ExchangeRates", code: 2, userInfo: [NSLocalizedDescriptionKey : "Query Interrupted"])
            }
        default:
            throw NSError(domain: "ExchangeRates", code: 3, userInfo: [NSLocalizedDescriptionKey : "A 5xx Error Server has occured"])
        }
    }
    
    func fetch(from input: String) async throws -> Rates {
        try await fetchRates(from: generateCurrencyExchange(from: input))
    }
    
}
