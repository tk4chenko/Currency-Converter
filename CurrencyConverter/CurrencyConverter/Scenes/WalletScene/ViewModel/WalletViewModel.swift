//
//  WalletViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import Foundation

class WalletViewModel {
    
    var totalBalance: Float = 0
    
    var wallets: Observable<[Wallet]?> = Observable(nil)
    
    private let realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func loadData() {
        realmManager.loadModels { wallets in
            self.wallets.value = wallets
        }
    }

}
