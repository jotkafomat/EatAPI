//
//  EatAPIRequestTest.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import XCTest
import Combine
@testable import EatAPI

class EatAPIRequestTest: XCTestCase {
    
    var api: EatAPIRequest!
    let baseUrl = "https://just.test/"
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        api = EatAPIRequest(session: session, baseUrl: baseUrl)
    }

    override func tearDownWithError() throws {
        api = nil
        MockURLProtocol.requestHandler = nil
        cancellable?.cancel()
    }

    func testGetRestaurantsDetailsWhenRequestSuccess() throws {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: self.baseUrl)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! Data(from: "exampleResponse")
            return (response, data)
        }
        
        let restaurantsLoaded = expectation(description: "restaurants get loaded")
        
        cancellable = api.getRestaurants(for: "postcode").sink { restaurants in
            XCTAssertEqual(restaurants.count, 505)
            XCTAssertEqual(restaurants[0].name, "Brixton Kebabish")
            XCTAssertEqual(restaurants[0].rating, 4.33)
            XCTAssertEqual(restaurants[0].cuisineTypes,
                           [Restaurant.CuisineType(id: 81, name: "Kebab"),
                            Restaurant.CuisineType(id: 78, name: "Burgers")])
            XCTAssertEqual(restaurants[0].logoURL, URL(string: "http://d30v2pzvrfyzpo.cloudfront.net/uk/images/restaurants/108446.gif"))
            restaurantsLoaded.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testGetRestaurantsDetailsWhenRequestFails() throws {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: self.baseUrl)!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        let restaurantsNotLoaded = expectation(description: "restaurants not loaded")
        
        cancellable = api.getRestaurants(for: "postcode").sink { restaurants in
            XCTAssertTrue(restaurants.isEmpty)
            restaurantsNotLoaded.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
