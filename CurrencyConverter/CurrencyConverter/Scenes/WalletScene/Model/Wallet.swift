//
//  Wallet.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 29.08.2023.
//

import Foundation
import RealmSwift

final class Wallet: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var code: String = ""
    @Persisted var amount: Float = 0.0
    @Persisted var usdAmmount: Float = 0.0
    
    convenience init(code: String, amount: Float) {
        self.init()
        self.code = code
        self.amount = amount
    }
}
