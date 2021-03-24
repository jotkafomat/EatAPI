//
//  MockReverseGeocoder.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import CoreLocation
@testable import EatAPI

struct MockReverseGeocoder: ReverseGeocoder {
    
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
        completionHandler([CLPlacemark.mock(for: location)], nil)
    }
}
