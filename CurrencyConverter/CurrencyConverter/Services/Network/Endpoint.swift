//
//  Endpoint.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var apikey: String? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "v6.exchangerate-api.com"
    }
}
