//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 31.08.2023.
//

import Foundation

extension String {
    
    func getSymbolForCurrencyCode() -> String {
        var candidates: [String] = []
        let locales: [String] = NSLocale.availableLocaleIdentifiers
        for localeID in locales {
            guard let symbol = findMatchingSymbol(localeID: localeID, currencyCode: self) else {
                continue
            }
            if symbol.count == 1 {
                return symbol
            }
            candidates.append(symbol)
        }
        let sorted = sortAscByLength(list: candidates)
        if sorted.count < 1 {
            return ""
        }
        return sorted[0]
    }

    func findMatchingSymbol(localeID: String, currencyCode: String) -> String? {
        let locale = Locale(identifier: localeID as String)
        guard let code = locale.currencyCode else {
            return nil
        }
        if code != currencyCode {
            return nil
        }
        guard let symbol = locale.currencySymbol else {
            return nil
        }
        return symbol
    }

    func sortAscByLength(list: [String]) -> [String] {
        return list.sorted(by: { $0.count < $1.count })
    }

}
