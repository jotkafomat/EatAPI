//
//  MockLocationManager.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import Foundation
import CoreLocation

@testable import EatAPI

class MockLocationManager: LocationManager {
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var delegate: CLLocationManagerDelegate?
    
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyReduced
    
    func requestLocation() {
        guard authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse else { return }
        
        delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [CLLocation(latitude: 50, longitude: 0)])
    }
    
    func requestWhenInUseAuthorization() {
        authorizationStatus = .authorizedWhenInUse
        delegate?.locationManagerDidChangeAuthorization!(CLLocationManager())
    }
}
