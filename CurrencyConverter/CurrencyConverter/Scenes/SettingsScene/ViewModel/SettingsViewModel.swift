//
//  SettingsViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

class SettingsViewModel {
    
    let currencyList = CurrencyManager.currencyList
    
    var selectedCurrency: Currency?
    
    private var currencyCode = UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCurrency) {
        didSet {
            UserDefaults.standard.set(currencyCode, forKey: Constants.UserDefaults.selectedCurrency)
            UserDefaults.standard.synchronize()
        }
    }
    
    func saveCurrency(_ currencyCode: String) {
        self.currencyCode = currencyCode
    }
    
    func getSelected() {
        if let selectedCurrencyCode = UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCurrency) {
            selectedCurrency = currencyList.first { $0.currencyCode == selectedCurrencyCode }
        } else {
            selectedCurrency = nil
        }
    }
}
