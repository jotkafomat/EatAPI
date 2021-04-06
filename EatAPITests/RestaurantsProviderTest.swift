//
//  RestaurantsProvider.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 11/03/2021.
//

import Combine
import Foundation
import XCTest
import CoreLocation
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

    func testRestaurantProviderSuccesfulRestaurantsGetUpdated() throws {
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
    
    func testRestaurantProviderSuccesfulRegionGetUpdated() throws {
        let expectation = XCTestExpectation(description: "expect region to get updated")
        
        cancellable = subject
            .$region
            .dropFirst()
            .sink {
                region in
                XCTAssertEqual(region.center.latitude, 51.439211)
                XCTAssertEqual(region.center.longitude, -0.130198)
                expectation.fulfill()
            }
        subject.postcode = "SW24PB"
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRestaurantProviderErrorRestaurantsDontChange() throws {
        let expectation = XCTestExpectation(description: "expect restaurants not to change")
        expectation.isInverted = true
        
        subject = RestaurantsProvider(
            restaurantFetcher: MockRestaurantFetcher.errorProne,
            postcodeProvider: MockPostcodeProvider())
        cancellable = subject
            .$restaurants
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
        subject.postcode = "SW24PB"
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRestaurantProviderErrorRegionDoesntChange() throws {
        let expectation = XCTestExpectation(description: "expect region not to change")
        expectation.isInverted = true
        
        subject = RestaurantsProvider(
            restaurantFetcher: MockRestaurantFetcher.errorProne,
            postcodeProvider: MockPostcodeProvider())
        cancellable = subject
            .$region
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
        subject.postcode = "SW24PB"
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetNearbyRestaurantsUpdateRestaurants() {
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
    
    func testGetNearbyRestaurantsUpdateRegion() {
        let expectation = XCTestExpectation(description: "expect region to be updated")
        
        cancellable = subject
            .$region
            .dropFirst()
            .sink {
                region in
                XCTAssertEqual(region.center.latitude, 51.439211)
                XCTAssertEqual(region.center.longitude, -0.130198)
                expectation.fulfill()
            }
        subject.getNearbyRestaurants()
        wait(for: [expectation], timeout: 1.0)
    }
}
