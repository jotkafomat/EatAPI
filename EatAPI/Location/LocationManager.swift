//
//  LocationManager.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import CoreLocation

protocol LocationManager {
    var authorizationStatus: CLAuthorizationStatus { get }
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    func requestLocation()
    func requestWhenInUseAuthorization()
}

extension CLLocationManager: LocationManager {}
