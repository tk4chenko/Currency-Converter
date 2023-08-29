//
//  Bid.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 29.08.2023.
//

import Foundation
import RealmSwift

class Bid: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var fromCode: String = ""
    @Persisted var toCode: String = ""
    @Persisted var fromAmount: Float = 0.0
    @Persisted var toAmount: Float = 0.0
    @Persisted var isOpen: Bool = false
    
    convenience init(fromCode: String, toCode: String, fromAmount: Float) {
        self.init()
        self.fromCode = fromCode
        self.toCode = toCode
        self.fromAmount = fromAmount
    }
}
