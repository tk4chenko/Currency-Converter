//
//  SelectedViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 28.08.2023.
//

import Foundation

protocol SelectedViewModelProtocol: AnyObject {
    var transferredCurrency: Currency? { get }
    var currencyList: [Currency] { get }
    var storedCurrency: Currency? { get }
    func saveCurrency(_ currencyCode: String)
    func backToPrevious(with currency: Currency?)
}

class SelectedViewModel: SelectedViewModelProtocol {
    
    private let currencyManager: CurrencyManagerProtocol
    
    var transferredCurrency: Currency?
    
    weak var coordinatorDelegate: SelectedCoordinatorDelegate?
    
    var currencyList: [Currency] {
        currencyManager.currencyList
    }
    
    var storedCurrency: Currency? {
        if let selectedCurrencyCode = UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCurrency) {
            return currencyManager.currencyList.first { $0.currencyCode == selectedCurrencyCode }
        } else {
            return currencyManager.currencyList.first { $0.currencyCode == "UAH" }
        }
    }
    
    init(currencyManager: CurrencyManagerProtocol) {
        self.currencyManager = currencyManager
    }
    
    func saveCurrency(_ currencyCode: String) {
        UserDefaults.standard.set(currencyCode, forKey: Constants.UserDefaults.selectedCurrency)
        UserDefaults.standard.synchronize()
    }
    
    func backToPrevious(with currency: Currency?) {
        coordinatorDelegate?.backToPrevious(currency: currency)
    }
}
