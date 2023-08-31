//
//  AddOwnedCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 31.08.2023.
//

import Foundation

protocol AddOwnedCurrencyViewModelProtocol {
    func saveWallet(_ wallet: Wallet) async
    func openSelectedCurrencyController(with currency: Currency?)
    func popViewController()
    func popToAddOwnedCurrencyController(with currency: Currency)
}

class AddOwnedCurrencyViewModel: AddOwnedCurrencyViewModelProtocol {
    
    private let realmManager: RealmManagerProtocol
    private let networkServise: CurrencyNetworkService
    
    weak var coordinatorDelegate: AddOwnedCurrencyCoordinatorDelegate?
    
    init(realmManager: RealmManagerProtocol, networkServise: CurrencyNetworkService) {
        self.realmManager = realmManager
        self.networkServise = networkServise
    }
    
    func saveWallet(_ wallet: Wallet) async {
        await getPair(fromCode: wallet.code, toCode: "USD", amount: wallet.amount) { response in
            wallet.usdAmmount = Float(response.conversionResult ?? 0)
            self.realmManager.saveModel(model: wallet)
        }
    }
    
    private func getPair(fromCode: String, toCode: String, amount: Float, completion: @escaping ((PairResponse)->Void)) async {
        do {
            let response: PairResponse = try await networkServise.getPair(with: (fromCode, toCode), amount: amount)
            completion(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func openSelectedCurrencyController(with currency: Currency?) {
        coordinatorDelegate?.openSelectedCurrencyController(with: currency)
    }
    
    func popViewController() {
        coordinatorDelegate?.popViewController()
    }
    
    func popToAddOwnedCurrencyController(with currency: Currency) {
        coordinatorDelegate?.popToAddOwnedCurrencyController(with: currency)
    }
}

