//
//  RestaurantsProvider.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Combine
import Foundation

class RestaurantsProvider: ObservableObject {
    
    @Published private (set) var restaurants = [Restaurant]()
    @Published var postcode: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    private let restaurantFetcher: RestaurantFetcher
    private let postcodeProvider: PostcodeProvider
    
    init(restaurantFetcher: RestaurantFetcher = EatAPIRequest(),
         postcodeProvider: PostcodeProvider = LocationBasedPostcodeProvider()) {
        self.restaurantFetcher = restaurantFetcher
        self.postcodeProvider = postcodeProvider
        $postcode
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] postcode in
                self?.getRestaurants(for: postcode)
            }
            .store(in: &cancellables)
    }
    
    func getNearbyRestaurants() {
        postcodeProvider
            .getCurrentPostcode()
            .compactMap { $0 }
            .sink { [weak self] postcode in
                self?.getRestaurants(for: postcode)
            }
            .store(in: &cancellables)
    }
    
    private func getRestaurants(for rawPostcode: String) {
        let postcode = applyFormatting(to: rawPostcode)
        
        restaurantFetcher
            .getRestaurants(for: postcode)
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
