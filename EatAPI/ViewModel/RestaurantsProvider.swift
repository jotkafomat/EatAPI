//
//  RestaurantsProvider.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Combine
import Foundation
import MapKit

class RestaurantsProvider: ObservableObject {
    
    @Published private (set) var restaurants = [Restaurant]()
    @Published var postcode: String = ""
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507928, longitude: -0.12792), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
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
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] response in
                self?.restaurants = response.restaurants
                self?.region = MKCoordinateRegion(center: response.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            }
            .store(in: &cancellables)
    }
}

extension RestaurantsProvider {
    private func applyFormatting(to rawTerm: String) -> String {
        rawTerm.replacingOccurrences(of: " ",
                                     with: "")
    }
}
