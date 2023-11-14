//
//  UnitDurationExtension.swift
//  Measurement
//
//  Created by Damien Chailloleau on 14/11/2023.
//

import Foundation

extension UnitDuration {
    static let days = UnitDuration(
        symbol: "day", converter: UnitConverterLinear(coefficient: 60 * 60 * 24, constant: 0)
    )
}
