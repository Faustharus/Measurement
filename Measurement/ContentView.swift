//
//  ContentView.swift
//  Measurement
//
//  Created by Damien Chailloleau on 14/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LengthView()
                .tabItem {
                    Label("Length", systemImage: "ruler")
                }
                .tag(0)
            
            TemperatureView()
                .tabItem {
                    Label("Temperature", systemImage: "thermometer.medium")
                }
                .tag(1)
            
            VolumeView()
                .tabItem {
                    Label("Volume", systemImage: "scalemass")
                }
                .tag(2)
            
            TimeView()
                .tabItem {
                    Label("Time", systemImage: "clock")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}

