//
//  Restaurant.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 10/03/2021.
//

import Foundation

struct Restaurant: Decodable {
    let id: Int
    let name: String
    let cuisineTypes: [CuisineType]
    let rating: Double
    let logoURL: URL?
    
    struct CuisineType: Decodable, Equatable {
        let id: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id = "Id"
            case name = "Name"
        }
    }
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case cuisineTypes = "CuisineTypes"
        case rating = "RatingAverage"
        case logoURL = "LogoUrl"
    }
}

struct EatAPIResponse: Decodable {
    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurants"
    }
}

