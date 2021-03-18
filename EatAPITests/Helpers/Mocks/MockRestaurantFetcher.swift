//
//  MockRestaurantFetcher.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Foundation
import Combine
@testable import EatAPI

enum MockRestaurantFetcher: RestaurantFetcher {
    
    case errorProne
    case succesful
    
    func getRestaurants(for postcode: String) -> AnyPublisher<[Restaurant], Never> {
        switch self {
        case .errorProne:
            return Just<[Restaurant]>([]).eraseToAnyPublisher()
        case .succesful:
            let decoder = JSONDecoder()
            let data = try? Data(from: "exampleResponse")
            let response = try? decoder.decode(EatAPIResponse.self, from: data!)
            return Just<[Restaurant]>(response?.restaurants ?? []).eraseToAnyPublisher()
            
        }
    }
}
