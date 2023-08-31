//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import Foundation

struct Currency: Decodable, Equatable {
    let currencyCode, currencyName: String
    var currencyCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case currencyCode = "Currency Code"
        case currencyName = "Currency Name"
        case currencyCountry
    }
}

typealias CurrencyResponse = [String: Currency]
