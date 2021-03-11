//
//  EatAPIRequest.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Foundation
import Combine

class EatAPIRequest: RestaurantFetcher {
    
    private let session: URLSession
    private let baseUrl: URL
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    public init(session: URLSession = URLSession.shared,
                baseUrl: URL = URL(string: "https://uk.api.just-eat.io/restaurants/bypostcode/sw24pb")!) {
        self.session = session
        self.baseUrl = baseUrl
    }
    func getRestaurants() -> AnyPublisher<[Restaurant], Never> {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        
        return session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: EatAPIResponse.self, decoder: EatAPIRequest.decoder)
            .map { $0.restaurants }
            .catch { _ in Just<[Restaurant]>([]) }
            .eraseToAnyPublisher()
    }
}
