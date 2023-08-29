//
//  AddBidCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 29.08.2023.
//

import Foundation

class AddBidCurrencyViewModel {
    
    private let realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func saveBid(_ bid: Bid) {
        realmManager.saveModel(model: bid)
    }
}
