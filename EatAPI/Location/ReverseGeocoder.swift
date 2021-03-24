//
//  ReverseGeocoder.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import Foundation
import CoreLocation

protocol ReverseGeocoder {
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void)
}

extension CLGeocoder: ReverseGeocoder {}
