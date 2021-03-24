//
//  LocationBasedPostcodeProvider.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 19/03/2021.
//

import Combine
import Foundation
import CoreLocation

final class LocationBasedPostcodeProvider: NSObject, PostcodeProvider {
    
    private let currentLocation = CurrentValueSubject<CLLocation?, Never>(nil)
    
    private let reverseGeocoder: ReverseGeocoder
    private var locationManager: LocationManager
    
    init(reverseGeocoder: ReverseGeocoder = CLGeocoder(),
         locationManager: LocationManager = CLLocationManager()) {
        self.reverseGeocoder = reverseGeocoder
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getCurrentPostcode() -> AnyPublisher<String?, Never> {
        
        startLocationServices()
        return currentLocation
            .compactMap { $0 }
            .flatMap { location in
                self.fetchPostcode(for: location)
            }
            .eraseToAnyPublisher()
    }
    
    private func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func fetchPostcode(for location: CLLocation) -> AnyPublisher<String?, Never> {
        
        Future<String?, Never> { [weak self] promise in
            self?.reverseGeocoder.reverseGeocodeLocation(location) { placemarks, _ in
                promise(.success(placemarks?.first?.postalCode))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension LocationBasedPostcodeProvider: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation.send(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
