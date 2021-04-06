//
//  Restaurant.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 10/03/2021.
//

import Foundation
import CoreLocation

struct Restaurant: Decodable, Identifiable {
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
    let coordinates: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurants"
        case coordinates = "MetaData"
    }
}

extension CLLocationCoordinate2D: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
}
