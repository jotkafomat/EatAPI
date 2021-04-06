//
//  RestaurantListView.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 29/03/2021.
//

import SwiftUI
import Kingfisher

struct RestaurantList: View {
    
    let restaurants: [Restaurant]
    
    var body: some View {
        List(restaurants) { restaurant in
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
