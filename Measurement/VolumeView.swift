//
//  VolumeView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 14/11/2023.
//

import SwiftUI

struct VolumeView: View {
    
    @State private var enterValue: Double = 0.0
    @State private var selectValueFrom: Int = 0
    @State private var selectValueTo: Int = 1
    
    @FocusState private var isValueFocused: Bool
    
    let volumeMeasure: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]
    let volumeText: [String] = ["mLiters", "Liters", "Cups", "Pints", "Gallons"]
    
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
                        ForEach(0 ..< volumeMeasure.count, id: \.self) { item in
                            Text("\(volumeText[item])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Select the Unit to Convert To") {
                    Picker("", selection: $selectValueTo) {
                        ForEach(0 ..< volumeMeasure.count, id: \.self) { item in
                            Text("\(volumeText[item])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(volumeCalculation, format: .number)
                }
            }
            .navigationTitle("Volume")
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
    VolumeView()
}

extension VolumeView {
    
    var volumeCalculation: Double {
        let generalVolume = Measurement(value: enterValue, unit: volumeMeasure[selectValueFrom])
        let result = generalVolume.converted(to: volumeMeasure[selectValueTo])
        
        return result.value
    }
    
}
