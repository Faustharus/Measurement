//
//  CurrencyView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import SwiftUI

struct CurrencyView: View {
    
    @State private var enterValue: Double = 0.0
    @State private var selectValueFrom: Int = 1
    @State private var selectValueTo: Int = 1
    
    @State private var selection: String = ""
    @State var exchanges = [String: Decimal]()
    
    @FocusState private var isValueFocused: Bool
    
    private let ratesAPI = ExchangeRateAPI.shared
    
    //let exchanges: Rates?
    
    let currencyText: [String] = ["EUR", "USD", "GBP", "JPY", "CAD", "AUD", "CHF", "CNY", "AED"]
    let currencyName: [String] = ["Euro", "US Dollar", "GB Pounds", "Japanese Yen", "Canadian Dollar", "Australian Dollar", "Swiss Franc", "Chinese Yuan", "United Arab Emirate Dihram"]
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Select the Unit to Convert From") {
                    Picker("", selection: $selectValueFrom) {
                        ForEach(0 ..< currencyText.count, id: \.self) { item in
                            Text("\(currencyText[item])")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Define your currencies") {
                    TextField("Add", text: $selection)
                }
                
                Section("Confirm") {
                    Button {
                        Task {
                            await loadExchangeRates()
                        }
                    } label: {
                        Text("Ask Request")
                    }
                }
                
                Section("Results") {
                    VStack {
                        ForEach(exchanges.sorted(by: >), id: \.key) { key, value in
                            Text("\(key): \(value, format: .currency(code: key))")
                        }
                    }
//                    if let exchanges = exchanges {
//                        VStack {
//                            Text("EUR: \(exchanges.eur)")
//                            Text("GBP: \(exchanges.gbp)")
//                            Text("JPY: \(exchanges.jpy)")
//                            Text("CNY: \(exchanges.cny)")
//                            Text("CAD: \(exchanges.cad)")
//                            Text("AUD: \(exchanges.aud)")
//                            Text("AED: \(exchanges.aed)")
//                        }
//                    } else {
//                        Text("No Data")
//                    }
                }
            }
            .navigationTitle("Currency")
        }
    }
}

#Preview {
    CurrencyView()
}

extension CurrencyView {
    
    func loadExchangeRates() async {
        do {
            exchanges = try await ratesAPI.fetch(from: currencyText[selectValueFrom], with: selection)
            print("\(exchanges.keys): \(exchanges.values)")
//            print("EUR: \(exchanges.eur)")
//            print("GBP: \(exchanges.gbp)")
//            print("JPY: \(exchanges.jpy)")
//            print("CNY: \(exchanges.cny)")
//            print("CAD: \(exchanges.cad)")
//            print("AUD: \(exchanges.aud)")
//            print("AED: \(exchanges.aed)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
