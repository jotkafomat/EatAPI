//
//  EatAPIResponseTest.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import XCTest
@testable import EatAPI

class EatAPIResponseTest: XCTestCase {
    
    var data: Data!
    
    override func setUpWithError() throws {
        data = try Data(from: "exampleResponse")
    }
    
    override func tearDownWithError() throws {
        data = nil
    }
    
    func testInitFromJson() throws {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(EatAPIResponse.self, from: data)
        XCTAssertEqual(response.restaurants.count, 505)
        let restaurant = try XCTUnwrap(response.restaurants.first)
        
        XCTAssertEqual(restaurant.name, "Brixton Kebabish")
        XCTAssertEqual(restaurant.rating, 4.33)
        XCTAssertEqual(restaurant.cuisineTypes,
                       [Restaurant.CuisineType(id: 81, name: "Kebab"),
                        Restaurant.CuisineType(id: 78, name: "Burgers")])
    }
    
    
}
