//
//  LengthView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 14/11/2023.
//

import SwiftUI

struct LengthView: View {
    
    @State private var enterValue: Double = 0.0
    @State private var selectValueFrom: Int = 0
    @State private var selectValueTo: Int = 1
    
    @FocusState private var isValueFocused: Bool
    
    let lengthMeasure: [UnitLength] = [.meters, .kilometers, .feet, .miles, .yards]
    let lengthText: [String] = ["Meters", "Km", "Feet", "Mile", "Yards"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Initial Value") {
                    TextField("Enter your value", value: $enterValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isValueFocused)
                }
                
                Section("Select the Unit to Convert From") {
                    Picker("", selection: $selectValueFrom) {
                        ForEach(0 ..< lengthMeasure.count, id: \.self) { item in
                            Text("\(lengthText[item])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Select the Unit to Convert To") {
                    Picker("", selection: $selectValueTo) {
                        ForEach(0 ..< lengthMeasure.count, id: \.self) { item in
                            Text("\(lengthText[item])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(lengthCalculation, format: .number)
                }
            }
            .navigationTitle("Length")
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
    LengthView()
}

extension LengthView {
    
    var lengthCalculation: Double {
        let generalLength = Measurement(value: enterValue, unit: lengthMeasure[selectValueFrom])
        let result = generalLength.converted(to: lengthMeasure[selectValueTo])
        
        return result.value
    }
    
}
