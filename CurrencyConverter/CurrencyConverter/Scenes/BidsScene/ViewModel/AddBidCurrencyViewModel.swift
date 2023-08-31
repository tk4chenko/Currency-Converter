//
//  AddBidCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 29.08.2023.
//

import Foundation

protocol AddBidCurrencyViewModelProtocol {
    func saveBid(_ bid: Bid) async
    func openSelectedCurrencyController(with currency: Currency?)
    func backToPrevious()
}

final class AddBidCurrencyViewModel: AddBidCurrencyViewModelProtocol {
    
    private let realmManager: RealmManagerProtocol
    private let networkServise: CurrencyNetworkService
    
    weak var coordinatorDelegate: AddDidCoordinatorDelegate?
    
    init(realmManager: RealmManagerProtocol, networkServise: CurrencyNetworkService) {
        self.realmManager = realmManager
        self.networkServise = networkServise
    }
    
    func saveBid(_ bid: Bid) async {
        await getPair(fromCode: bid.fromCode, toCode: bid.toCode, amount: bid.fromAmount) { response in
            bid.toAmount = Float(response.conversionResult ?? 0)
            self.realmManager.saveModel(model: bid)
        }
    }
    
    func openSelectedCurrencyController(with currency: Currency?) {
        coordinatorDelegate?.openSelectedCurrencyController(with: currency)
    }
    
    func backToPrevious() {
        coordinatorDelegate?.popViewController()
    }
    
    private func getPair(fromCode: String, toCode: String, amount: Float, completion: @escaping ((PairResponse)->Void)) async {
        do {
            let response: PairResponse = try await networkServise.getPair(with: (fromCode, toCode), amount: amount)
            completion(response)
        } catch {
            print(error.localizedDescription)
        }
    }
}
