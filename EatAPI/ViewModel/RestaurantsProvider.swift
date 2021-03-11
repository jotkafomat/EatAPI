//
//  RestaurantsProvider.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Foundation

class RestaurantsProvider: ObservableObject {
    
    @Published private (set) var restaurants = [Restaurant]()
    
    private let restaurantFetcher: RestaurantFetcher
    
    init(restaurantFetcher: RestaurantFetcher) {
        self.restaurantFetcher = restaurantFetcher
    }
    
    func getRestaurants() {
        restaurantFetcher
            .getRestaurants()
            .receive(on: RunLoop.main)
            .assign(to: &$restaurants)
    }
}
