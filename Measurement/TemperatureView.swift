//
//  TemperatureView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 14/11/2023.
//

import SwiftUI

struct TemperatureView: View {
    
    @State private var enterValue: Double = 0.0
    @State private var selectValueFrom: Int = 0
    @State private var selectValueTo: Int = 1
    
    @FocusState private var isValueFocused: Bool
    
    let tempMeasure: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Initial Value") {
                    TextField("Value", value: $enterValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isValueFocused)
                }
                
                Section("Select the Unit to Convert From") {
                    Picker("", selection: $selectValueFrom) {
                        ForEach(0 ..< tempMeasure.count, id: \.self) { item in
                            Text(tempMeasure[item].symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Select the Unit to Convert To") {
                    Picker("", selection: $selectValueTo) {
                        ForEach(0 ..< tempMeasure.count, id: \.self) { item in
                            Text(tempMeasure[item].symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(temperatureCalculation, format: .number)
                }
            }
            .navigationTitle("Temperature")
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
    TemperatureView()
}

// MARK: Computed Properties
extension TemperatureView {
    
    var temperatureCalculation: Double {
        let generalTemp = Measurement(value: enterValue, unit: tempMeasure[selectValueFrom])
        let result = generalTemp.converted(to: tempMeasure[selectValueTo])
        
        return result.value
    }
    
}
