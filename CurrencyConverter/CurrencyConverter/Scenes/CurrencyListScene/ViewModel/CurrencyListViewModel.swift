//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

class CurrencyListViewModel {
    
    private let networkService: CurrencyNetworkServiceProtocol
    
    private var selectedCurrency: String = "UAH"
    
    let currencyList: Observable<LatestResponse?> = Observable(nil)
    let error: Observable<String?> = Observable(nil)
    
    init(networkService: CurrencyNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func loadData() async {
        selectedCurrency = UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCurrency) ?? "UAH"
        do {
            currencyList.value = try await networkService.getLatest(by: selectedCurrency)
        } catch {
            self.error.value = error.localizedDescription
        }
    }
}
