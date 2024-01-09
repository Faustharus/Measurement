//
//  CurrencyView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import SwiftUI

struct CurrencyView: View {
    
    @StateObject var currencyVM = CurrencyViewModel()
    
    @FocusState private var isValueFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Text("⚠️ Default Base Currency is in Euro € ⚠️")
                    .font(.system(size: 17, weight: .light, design: .default))
                
                Section("Define when") {
                    DisclosureGroup {
                        DatePicker("", selection: $currencyVM.currentDate, in: currencyVM.dateRange, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                    } label: {
                        Label("Select a date", systemImage: "calendar")
                    }
                }
                
                Section("Define an Amount") {
                    TextField("Initial Value at €1,00", value: $currencyVM.enterValue, format: .currency(code: "EUR"))
                        .keyboardType(.decimalPad)
                }
                
                Section("Define your currencies") {
                    TextField("Ex: EUR,USD,GBP or JPY", text: $currencyVM.selection)
                        .keyboardType(.alphabet)
                }
                
                Section("Results") {
                    HStack {
                        ForEach(currencyVM.exchanges.sorted(by: >), id: \.key) { key, value in
                            VStack {
                                HStack(spacing: 5) {
                                    Text("-")
                                    Text("\(value * currencyVM.enterValue, format: .currency(code: key).sign(strategy: .accounting))")
                                    Text("-")
                                }
                            }
                        }
                    }
                }
                
                Section("Confirm") {
                    Button {
                        Task {
                            await loadData()
                        }
                    } label: {
                        Text("Ask Request")
                    }
                    .disabled(currencyVM.selection.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || ((currencyVM.selection.rangeOfCharacter(from: .decimalDigits)?.isEmpty) != nil) || currencyVM.enterValue.isZero)
                }
                
            }
            .navigationTitle("Currency")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // TODO: Help Sheet Here
                    } label: {
                        Label("Help", systemImage: "questionmark.circle")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Ask Request
                    } label: {
                        Label("API Request", systemImage: "hourglass")
                    }
                }
            }
        }
    }
}

#Preview {
    CurrencyView()
}

extension CurrencyView {
    
    func loadData() async {
        await currencyVM.loadExchangeRates()
    }
    
}
