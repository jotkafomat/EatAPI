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
            }   .padding()
            List(restaurants.restaurants) { restaurant in
                HStack {
                    KFImage(restaurant.logoURL)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 5)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(restaurants: RestaurantsProvider())
    }
}
