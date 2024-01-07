//
//  CurrencyView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import SwiftUI

struct CurrencyView: View {
    
    @State private var enterValue: Double = 0.0
    @State private var selectValueFrom: Int = 0
    @State private var selectValueTo: Int = 1
    
    @FocusState private var isValueFocused: Bool
    
    private let ratesAPI = ExchangeRateAPI.shared
    
    let currencyText: [String] = ["EUR", "USD", "GBP", "JPY", "CAD", "AUD", "CHF", "CNY", "AED"]
    let currencyName: [String] = ["Euro", "US Dollar", "GB Pounds", "Japanese Yen", "Canadian Dollar", "Australian Dollar", "Swiss Franc", "Chinese Yuan", "United Arab Emirate Dihram"]
    
    var body: some View {
        NavigationStack {
            Form {
//                Section("Amount to Convert") {
//                    TextField("Enter your value", value: $enterValue, format: .number)
//                        .keyboardType(.decimalPad)
//                        .focused($isValueFocused)
//                }
                
                Section("Select the Unit to Convert From") {
                    Picker("", selection: $selectValueFrom) {
                        ForEach(0 ..< currencyText.count, id: \.self) { item in
                            Text("\(currencyName[item]) - \(currencyText[item])")
                        }
                    }
                    .pickerStyle(.menu)
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
                    
                }
                
//                Section("Select the Unit to Convert To") {
//                    Picker("", selection: $selectValueTo) {
//                        ForEach(0 ..< currencyText.count, id: \.self) { item in
//                            Text("\(currencyName[item]) - \(currencyText[item])")
//                        }
//                    }
//                    .pickerStyle(.menu)
//                }
            }
            .navigationTitle("Currency")
            .toolbar {
                Button("Done") {
                    self.isValueFocused = false
                }
                .disabled(!isValueFocused)
            }
        }
    }
}

#Preview {
    CurrencyView()
}

extension CurrencyView {
    
    func loadExchangeRates() async {
        do {
            let exchanges = try await ratesAPI.fetch(from: currencyText[selectValueFrom])
            print("\(exchanges.signatureRate.keys): \(exchanges.signatureRate.values)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
