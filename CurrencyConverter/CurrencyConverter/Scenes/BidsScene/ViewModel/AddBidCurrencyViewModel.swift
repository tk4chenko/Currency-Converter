//
//  AddBidCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 29.08.2023.
//

import Foundation

class AddBidCurrencyViewModel {
    
    private let realmManager: RealmManagerProtocol
    private let networkServise: CurrencyNetworkService
    
    init(realmManager: RealmManagerProtocol, networkServise: CurrencyNetworkService) {
        self.realmManager = realmManager
        self.networkServise = networkServise
    }
    
    func saveBid(_ bid: Bid) {
        Task {
            await getPair(fromCode: bid.fromCode, toCode: bid.toCode, amount: bid.fromAmount) { response in
                bid.toAmount = Float(response.conversionResult ?? 0)
                self.realmManager.saveModel(model: bid)
            }
        }
    }
    
    func getPair(fromCode: String, toCode: String, amount: Float, completion: @escaping ((PairResponse)->Void)) async {
        do {
            let response: PairResponse = try await networkServise.getPair(with: (fromCode, toCode), amount: amount)
            completion(response)
        } catch {
            print(error.localizedDescription)
        }
    }
}
