//
//  RestaurantFetcher.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Foundation
import Combine

protocol RestaurantFetcher {
    func getRestaurants(for postcode: String) -> AnyPublisher<EatAPIResponse?, Never>
}
