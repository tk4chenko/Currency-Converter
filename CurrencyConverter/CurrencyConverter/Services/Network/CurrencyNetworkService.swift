//
//  CurrencyNetworkService.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation

protocol CurrencyNetworkServiceProtocol {
    func getLatest(by currency: String) async throws -> LatestResponse
    func getPair(with currencies: (String, String)) async throws -> PairResponce
}

struct CurrencyNetworkService: HTTPClient, CurrencyNetworkServiceProtocol {
    
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    
    func getLatest(by currency: String) async throws -> LatestResponse {
        do {
            return try await sendRequest(
                endpoint: CurrencyEndpoint.getLatest(currency),
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
    
    func getPair(with currencies: (String, String)) async throws -> PairResponce {
        do {
            return try await sendRequest(
                endpoint: CurrencyEndpoint.getPair(currencies), decoder: decoder
            )
        } catch {
            throw error
        }
    }

}
