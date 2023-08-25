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
    let conversionRates: [String: Double]?
}

struct CurrencyWithCountry {
    let currency: Currency
    let country: String?
}
