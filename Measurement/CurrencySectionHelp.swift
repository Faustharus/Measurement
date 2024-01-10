//
//  CurrencySectionHelp.swift
//  Measurement
//
//  Created by Damien Chailloleau on 09/01/2024.
//

import SwiftUI

struct CurrencySectionHelp: View {
    
    let currencies = Bundle.main.decode([Currencies].self, from: "currencies.json")
    
    var body: some View {
        VStack(spacing: 10) {
            Text("⚠️ Default Base Currency is in Euro € ⚠️")
                .font(.system(size: 17, weight: .bold, design: .default))
                .lineLimit(2)
            
            List {
                ForEach(currencies, id: \.self) { section in
                    DisclosureGroup {
                        Section(header: Text(section.continent)) {
                            ForEach(section.countries, id: \.self) { item in
                                HStack(spacing: 5) {
                                    Text(item.acronym)
                                    Text("-")
                                    Text(item.name)
                                }
                            }
                        }
                    } label: {
                        Label("\(section.continent)", systemImage: worldIcon(section.continent))
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    CurrencySectionHelp()
}

extension CurrencySectionHelp {
    
    func worldIcon(_ contient: String) -> String {
        switch contient {
        case "America":
            return "globe.americas"
        case "Oceania":
            return "globe.asia.australia"
        case "Africa":
            return "globe.europe.africa"
        case "Asia":
            return "globe.central.south.asia"
        default:
            return "globe.europe.africa"
        }
    }
    
}
