//
//  LatestResponse.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

struct LatestResponse: Codable {
    let result: String?
    let documentation, termsOfUse: String?
    let timeLastUpdateUnix: Int?
    let timeLastUpdateUTC: String?
    let timeNextUpdateUnix: Int?
    let timeNextUpdateUTC, baseCode: String?
    let conversionRates: [String: Float]?
}

struct LatestCurrency {
    let currencyCode, currencyName, currencyCountry, baseCode: String
    let amount: Float
}
