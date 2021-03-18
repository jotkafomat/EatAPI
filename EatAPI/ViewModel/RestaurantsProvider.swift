//
//  RestaurantsProvider.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Foundation

class RestaurantsProvider: ObservableObject {
    
    @Published private (set) var restaurants = [Restaurant]()
    @Published var postcode: String = ""
    
    init(restaurantFetcher: RestaurantFetcher) {
        $postcode
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .removeDuplicates()
            .map(applyFormatting)
            .flatMap(restaurantFetcher.getRestaurants)
            .receive(on: RunLoop.main)
            .assign(to: &$restaurants)
    }
}

extension RestaurantsProvider {
    private func applyFormatting(to rawTerm: String) -> String {
        rawTerm.replacingOccurrences(of: " ",
                                     with: "")
    }
}
