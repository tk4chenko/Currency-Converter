//
//  SettingsViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

class SettingsViewModel {
    
    let currencyManager: CurrencyManagerProtocol
    
    var currencyList: [Currency] {
        currencyManager.currencyList
    }
    
    var selectedCurrency: Currency? {
        get {
            if let selectedCurrencyCode = UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCurrency) {
                return currencyManager.currencyList.first { $0.currencyCode == selectedCurrencyCode }
            } else {
                return currencyManager.currencyList.first { $0.currencyCode == "UAH" }
            }
        }
    }
    
    init(currencyManager: CurrencyManagerProtocol) {
        self.currencyManager = currencyManager
    }
    
}
