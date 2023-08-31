//
//  WalletViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import Foundation

protocol WalletViewModelProtocol {
    var totalBalance: Float { get }
    var wallets: Observable<[Wallet]?> { get }
    var filteredCurrencies: [Wallet] { get set }
    func loadData()
    func deleteWallet(_ wallet: Wallet)
    func openAddOwnedCurrencyController()
}

final class WalletViewModel: WalletViewModelProtocol {
    
    private let realmManager: RealmManagerProtocol
    
    let wallets: Observable<[Wallet]?> = Observable(nil)
    
    var filteredCurrencies: [Wallet] = []
    
    var totalBalance: Float = 0 {
        didSet {
            totalBalance = totalBalance.roundedToTwoDecimalPlaces()
        }
    }
    
    weak var coordinatorDelegate: WalletViewCoordinatorDelegate?

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func loadData() {
        self.totalBalance = 0
        realmManager.loadModels { [weak self] (wallets: [Wallet]) in
            self?.wallets.value = wallets.reversed()
            self?.filteredCurrencies = wallets.reversed()
            for wallet in wallets {
                self?.totalBalance += wallet.usdAmmount
            }
        }
    }
    
    func deleteWallet(_ wallet: Wallet) {
        realmManager.deleteModel(model: wallet)
    }
    
    func openAddOwnedCurrencyController() {
        coordinatorDelegate?.openAddOwnedCurrencyController()
    }
}
