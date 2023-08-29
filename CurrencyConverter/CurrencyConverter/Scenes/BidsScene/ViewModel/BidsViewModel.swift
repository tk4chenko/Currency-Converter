//
//  BidsViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import Foundation

class BidsViewModel {
    
    var bids: Observable<[Bid]?> = Observable(nil)
    
    private let realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func loadData() {
        realmManager.loadModels { bids in
//            print(bids)
            self.bids.value = bids
        }
    }

}
