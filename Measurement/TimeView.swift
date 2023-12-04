//
//  TimeView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 14/11/2023.
//

import SwiftUI

struct TimeView: View {
    
    @State private var enterValue: Double = 0.0
    @State private var selectValueFrom: Int = 0
    @State private var selectValueTo: Int = 1
    
    @FocusState private var isValueFocused: Bool
    
    let timeMeasure: [UnitDuration] = [.seconds, .minutes, .hours, .days]
    let timeText: [String] = ["Seconds", "Minutes", "Hours", "Days"]
    
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
                        ForEach(0 ..< timeMeasure.count, id: \.self) { item in
                            Text("\(timeText[item])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Select the Unit to Convert To") {
                    Picker("", selection: $selectValueTo) {
                        ForEach(0 ..< timeMeasure.count, id: \.self) { item in
                            Text("\(timeText[item])")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(timeCalculation, format: .number)
                }
            }
            .navigationTitle("Time")
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
    TimeView()
}

// MARK: Computed Properties
extension TimeView {
    
    var timeCalculation: Double {
        let generalTime = Measurement(value: enterValue, unit: timeMeasure[selectValueFrom])
        let result = generalTime.converted(to: timeMeasure[selectValueTo])
        
        return result.value
    }
    
}
