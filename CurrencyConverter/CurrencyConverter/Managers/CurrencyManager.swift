//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import Foundation

protocol CurrencyManagerProtocol {
    var selectedCurrency: Currency? { get }
    var currencyList: [Currency] { get }
}

final class CurrencyManager: CurrencyManagerProtocol, JSONLoader {
    
    var selectedCurrency: Currency? {
        if let selectedCurrency = currencyList.first(where: { $0.currencyCode == UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCurrency) }) {
            return selectedCurrency
        } else {
            return currencyList.first(where: { $0.currencyCode == UserDefaults.standard.string(forKey: "UAH") }) ?? nil
        }
    }
    
    var currencyList: [Currency] {
        let localResponse: CurrencyResponse = CurrencyManager.load(Constants.JSON.filename)
        
        var formattedCurrencies: [Currency] = []
        
        for (key, value) in localResponse {
            var formattedCurrency = value
            formattedCurrency.currencyCountry = key
            
            formattedCurrencies.append(formattedCurrency)
        }
        return formattedCurrencies.sorted { $0.currencyName < $1.currencyName }
    }
}
