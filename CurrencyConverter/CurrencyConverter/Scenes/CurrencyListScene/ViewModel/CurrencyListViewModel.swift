//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

protocol CurrencyListViewModelProtocol {
    var currencyList: Observable<[LatestCurrency]?> { get }
    var error: Observable<String?> { get }
    func loadData() async
}

final class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    private let networkService: CurrencyNetworkServiceProtocol
    private let currencyManager: CurrencyManagerProtocol
    
    let currencyList: Observable<[LatestCurrency]?> = Observable(nil)
    let error: Observable<String?> = Observable(nil)
    
    init(networkService: CurrencyNetworkServiceProtocol, currencyManager: CurrencyManagerProtocol) {
        self.networkService = networkService
        self.currencyManager = currencyManager
    }
    
    func loadData() async {
        do {
            let response: LatestResponse = try await networkService.getLatest(by: currencyManager.selectedCurrency?.currencyCode ?? "UAH")
            
            var currencyList: [LatestCurrency] = []
            if let conversionRates = response.conversionRates {
                let sortedKeys = conversionRates.keys.sorted(by: <)
                
                for key in sortedKeys {
                    if let currencyCountry = currencyManager.currencyList.first(where: { $0.currencyCode == key })?.currencyCountry,
                       let currencyName = currencyManager.currencyList.first(where: { $0.currencyCode == key })?.currencyName,
                       let baseCode = response.baseCode,
                       let amount = conversionRates[key] {
                        let currency = LatestCurrency(currencyCode: key, currencyName: currencyName, currencyCountry: currencyCountry, baseCode: baseCode, amount: amount)
                        currencyList.append(currency)
                    }
                }
            }
            self.currencyList.value = currencyList
        } catch {
            self.error.value = error.localizedDescription
        }
    }
}
