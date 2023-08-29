//
//  PairResponce.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import Foundation

struct PairResponse: Codable {
    let result: String?
    let documentation, termsOfUse: String?
    let timeLastUpdateUnix: Int?
    let timeLastUpdateUTC: String?
    let timeNextUpdateUnix: Int?
    let timeNextUpdateUTC, baseCode, targetCode: String?
    let conversionRate, conversionResult: Double?
}
