//
//  ContentView.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 10/03/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var restaurants: RestaurantsProvider
    @State var showMap = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    restaurants.getNearbyRestaurants()
                } label: {
                    Image(systemName: "mappin.circle.fill")
                        .imageScale(.large)
                }
                TextField("or type in your postcode", text: $restaurants.postcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    withAnimation {
                        showMap.toggle()
                    }
                } label: {
                    Image(systemName: showMap ? "list.bullet" : "map")
                        .imageScale(.large)
                }
            }   .padding()
            if showMap {
                MapView(region: $restaurants.region)
            } else {
                RestaurantList(restaurants: restaurants.restaurants)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(restaurants: RestaurantsProvider())
    }
}
