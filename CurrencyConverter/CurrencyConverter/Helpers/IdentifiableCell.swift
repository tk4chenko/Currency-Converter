//
//  Identifiable.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

protocol IdentifiableCell {}

extension IdentifiableCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
