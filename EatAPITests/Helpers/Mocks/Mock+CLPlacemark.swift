//
//  Mock+CLPlacemark.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import CoreLocation
import Contacts
import Intents

extension CLPlacemark {
    
    static func mock(for location: CLLocation) -> CLPlacemark {
        let address = CNMutablePostalAddress()
        address.postalCode = "W5 3LL"
        return CLPlacemark(location: location,
                           name: "just mock",
                           postalAddress: address)
    }
}
