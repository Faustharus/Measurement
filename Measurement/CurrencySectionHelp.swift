//
//  CurrencySectionHelp.swift
//  Measurement
//
//  Created by Damien Chailloleau on 09/01/2024.
//

import SwiftUI

struct CurrencySectionHelp: View {
    
    let currencies = Bundle.main.decode([Currencies].self, from: "currencies.json")
    
    let currencyText: [String] = ["EUR", "USD", "GBP", "JPY", "CAD", "AUD", "NZD", "CHF", "CNY", "AED", "ZAR", "DZD", "MAD", "TND", "EGP", "KRW", "MXN", "BRL", "ISK", "SEK", "DKK", "NOK", "THB", "MYR"]
    let currencyName: [String] = ["Euro", "US Dollar", "GB Pounds", "Japanese Yen", "Canadian Dollar", "Australian Dollar", "New Zealand Dollar", "Swiss Franc", "Chinese Yuan Renmibi", "United Arab Emirate Dihram", "South African Rand", "Algerian Dinar", "Moroccan Dirham", "Tunisian Dinar", "Egyptian Pound", "South Korean Won", "Mexican Peso", "Brazilian Real", "Icelandic Krona", "Swedish Krona", "Danish Krone", "Norgewian Krone", "Thai Baht", "Malaysian Ringgit"]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("⚠️ Default Base Currency is in Euro € ⚠️")
                .font(.system(size: 17, weight: .light, design: .default))
                .underline(color: .red)
            
            List {
                ForEach(currencies, id: \.self) { section in
                    Section(header: Text(section.continent)) {
                        ForEach(section.countries, id: \.self) { item in
                            HStack(spacing: 5) {
                                Text(item.acronym)
                                Text("-")
                                Text(item.name)
                            }
                        }
                    }
                }
            }
            
//            VStack(alignment: .leading) {
//                ForEach(0 ..< currencyText.count, id: \.self) { item in
//                    HStack {
//                        Text("\(currencyText[item])")
//                        Text("-")
//                        Text("\(currencyName[item])")
//                    }
//                }
//            }
        }
    }
}

#Preview {
    CurrencySectionHelp()
}
