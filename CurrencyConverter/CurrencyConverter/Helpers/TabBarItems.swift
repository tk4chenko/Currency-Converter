//
//  TabBarItems.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

enum TabBarItems: String {
    case currencyList, wallet, bids, settings
    var image: UIImage? {
        switch self {
        case .currencyList:
            return UIImage(named: "currencyList")
        case .wallet:
            return UIImage(named: "wallet")
        case .bids:
            return UIImage(named: "bids")
        case .settings:
            return UIImage(named: "settings")
        }
    }
}
