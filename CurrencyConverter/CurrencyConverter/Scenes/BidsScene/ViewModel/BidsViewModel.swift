//
//  BidsViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import Foundation

protocol BidsViewModelProtocol {
    var bids: Observable<[Bid]?> { get }
    var filteredBids: [Bid] { get set } 
    func loadData()
    func deleteBid(_ bid: Bid)
    func openAddBidCurrencyController()
}

final class BidsViewModel: BidsViewModelProtocol {
    
    private let realmManager: RealmManagerProtocol
    
    weak var coordinatorDelegate: BidsViewCoordinatorDelegate?
    
    let bids: Observable<[Bid]?> = Observable(nil)
    var filteredBids: [Bid] = []
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
    
    func loadData() {
        realmManager.loadModels { [weak self] (bids: [Bid]) in
            self?.bids.value = bids.reversed()
            self?.filteredBids = bids.reversed()
        }
    }
    
    func deleteBid(_ bid: Bid) {
        realmManager.deleteModel(model: bid)
    }
    
    func openAddBidCurrencyController() {
        coordinatorDelegate?.openAddBidCurrencyController()
    }
}
