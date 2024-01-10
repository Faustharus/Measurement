//
//  CurrencyView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 07/01/2024.
//

import SwiftUI

struct CurrencyView: View {
    
    @StateObject var currencyVM = CurrencyViewModel()
    
    @State private var isHelpOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
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
                        .submitLabel(.continue)
                }
                
                Section("Define your currencies") {
                    TextField("Ex: EUR,USD,GBP or JPY", text: $currencyVM.selection)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()
                        .keyboardType(.alphabet)
                        .submitLabel(.done)
                }
                
                Section("Results") {
                    VStack(alignment: .leading) {
                        ForEach(currencyVM.exchanges.sorted(by: >), id: \.key) { key, value in
                            HStack {
                                    Text("\(value * currencyVM.enterValue, format: .currency(code: key).sign(strategy: .accounting))")
                                    .frame(height: 25)
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Currency")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isHelpOpen = true
                    } label: {
                        Label("Help", systemImage: "questionmark.circle")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await loadData()
                        }
                    } label: {
                        Label("API Request", systemImage: "hourglass")
                    }
                    .disabled(currencyVM.selection.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || ((currencyVM.selection.rangeOfCharacter(from: .decimalDigits)?.isEmpty) != nil) || currencyVM.enterValue.isZero)
                }
            }
            .sheet(isPresented: $isHelpOpen) {
                CurrencySectionHelp()
                    .presentationDetents([.fraction(0.5)])
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
