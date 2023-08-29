//
//  BidsViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import Foundation

class BidsViewModel {
    
    let bids: Observable<[Bid]?> = Observable(nil)
    
    private let realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func loadData() {
        realmManager.loadModels { [weak self] bids in
            self?.bids.value = bids.reversed()
        }
    }
    
    func deleteBid(_ bid: Bid) {
        realmManager.deleteModel(model: bid)
    }

}
