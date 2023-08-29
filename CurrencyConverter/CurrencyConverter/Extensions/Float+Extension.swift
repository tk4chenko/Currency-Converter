//
//  Float+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 28.08.2023.
//

import Foundation

extension Float {
    func roundedToTwoDecimalPlaces() -> Float {
        let multiplier: Float = 100.0
        return (self * multiplier).rounded() / multiplier
    }
}
