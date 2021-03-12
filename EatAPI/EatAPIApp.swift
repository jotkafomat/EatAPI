//
//  EatAPIApp.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 10/03/2021.
//

import SwiftUI

@main
struct EatAPIApp: App {
    var restaurants = RestaurantsProvider(restaurantFetcher: EatAPIRequest())
    
    var body: some Scene {
        WindowGroup {
            ContentView(restaurants: restaurants)
        }
    }
}
