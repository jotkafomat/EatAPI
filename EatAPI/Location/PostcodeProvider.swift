//
//  PostcodeProvider.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import Foundation
import Combine

protocol PostcodeProvider {
    func getCurrentPostcode() -> AnyPublisher<String?, Never>
}


