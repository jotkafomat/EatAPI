//
//  LocationBasedPostcodeProviderTest.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//
import CoreLocation
import Combine
import XCTest
@testable import EatAPI

class LocationBasedPostcodeProviderTest: XCTestCase {
    
    var subject: LocationBasedPostcodeProvider!
    var cancellable: AnyCancellable?

    override func setUpWithError() throws {
        subject = LocationBasedPostcodeProvider(reverseGeocoder: MockReverseGeocoder(), locationManager: MockLocationManager())
    }

    override func tearDownWithError() throws {
        subject = nil
        cancellable?.cancel()
    }
    
    func testGetCurrentPostcode() {
        let expectation = XCTestExpectation(description: "postcode is not nil")
        
        cancellable = subject
            .getCurrentPostcode()
            .sink { postcode in
                XCTAssertNotNil(postcode)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 1)
    }

}
