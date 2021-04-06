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
    private let baseUrl: String
    
    public init(session: URLSession = URLSession.shared,
                baseUrl: String = "https://uk.api.just-eat.io/restaurants/bypostcode/") {
        self.session = session
        self.baseUrl = baseUrl
    }
    
    func getRestaurants(for postcode: String) -> AnyPublisher<EatAPIResponse?, Never> {
        let url = URL(string: baseUrl + postcode)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: EatAPIResponse?.self, decoder: JSONDecoder())
            .catch { _ in Just<EatAPIResponse?>(nil) }
            .eraseToAnyPublisher()
    }
}
