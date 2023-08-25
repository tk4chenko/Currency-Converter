//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import Foundation

struct CurrencyManager: JSONLoader {
    static var currencyList: [Currency] {
        let localResponse: CurrencyResponse = load(Constants.JSON.filename)

        var formattedCurrencies: [Currency] = []
        
        for (key, value) in localResponse {
            var formattedCurrency = value
            formattedCurrency.currencyCountry = key
            
            formattedCurrencies.append(formattedCurrency)
        }
        return formattedCurrencies.sorted { $0.currencyName < $1.currencyName }
    }
}
