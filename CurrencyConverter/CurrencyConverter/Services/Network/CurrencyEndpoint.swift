//
//  CurrencyEndpoint.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

enum CurrencyEndpoint {
    case getLatest(_ currency: String)
    case getPair(_ currencies: (String, String))
}

extension CurrencyEndpoint: Endpoint {
    var apikey: String? {
        return "/v6/\(Constants.API.apiKey)"
    }
    var path: String {
        switch self {
        case .getLatest(let currency):
            return "/latest/\(currency)"
        case .getPair(let currencies):
            return "/pair/\(currencies.0)/\(currencies.1)"
        }
            
    }
    var method: RequestMethod {
        switch self {
        case .getLatest(_):
            return .get
        case .getPair((_, _)):
            return .get
        }
    }
    var header: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
}
