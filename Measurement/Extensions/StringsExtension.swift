//
//  StringsExtension.swift
//  Measurement
//
//  Created by Damien Chailloleau on 09/01/2024.
//

import Foundation

extension String {
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var isDouble: Bool {
        return Double(self) != nil
    }
    
}
