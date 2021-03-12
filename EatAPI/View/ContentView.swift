//
//  ContentView.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 10/03/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var restaurants: RestaurantsProvider
    
    var body: some View {
        List(restaurants.restaurants) { restaurant in
            HStack {
                KFImage(restaurant.logoURL)
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(restaurant.name)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                VStack {
                    Text("Rating:")
                    Text(String(restaurant.rating))
                }
            }
        }
        .onAppear {
            restaurants.getRestaurants()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(restaurants: RestaurantsProvider(
                        restaurantFetcher: EatAPIRequest()))
    }
}
