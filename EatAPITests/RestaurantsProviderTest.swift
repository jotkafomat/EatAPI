//
//  RestaurantsProvider.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Combine
import Foundation
import XCTest
@testable import EatAPI


class RestaurantsProviderTest: XCTestCase {
    
    var subject: RestaurantsProvider!
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        subject = RestaurantsProvider(
            restaurantFetcher: MockRestaurantFetcher.succesful,
            postcodeProvider: MockPostcodeProvider())
    }

    override func tearDownWithError() throws {
        subject = nil
        cancellable?.cancel()
    }

    func testRestaurantProviderSuccesful() throws {
        let expectation = XCTestExpectation(description: "expect restaurants not be empty")
        
        cancellable = subject
            .$restaurants
            .dropFirst()
            .sink {
                restaurants in
                XCTAssertEqual(restaurants.first?.name, "Brixton Kebabish")
                expectation.fulfill()
            }
        subject.postcode = "SW24PB"
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRestaurantProviderError() throws {
        
        let expectation = XCTestExpectation(description: "expect restaurants to be empty")
        subject = RestaurantsProvider(
            restaurantFetcher: MockRestaurantFetcher.errorProne,
            postcodeProvider: MockPostcodeProvider())
        cancellable = subject
            .$restaurants
            .dropFirst()
            .sink {
                restaurants in
                XCTAssert(restaurants.isEmpty)
                expectation.fulfill()
            }
        subject.postcode = "SW24PB"
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetNearbyRestaurants() {
        let expectation = XCTestExpectation(description: "expect restaurants not be empty")
        
        cancellable = subject
            .$restaurants
            .dropFirst()
            .sink {
                restaurants in
                XCTAssertFalse(restaurants.isEmpty)
                expectation.fulfill()
                
            }
        subject.getNearbyRestaurants()
        wait(for: [expectation], timeout: 1.0)
    }
}
