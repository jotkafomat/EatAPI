//
//  MockPostcodeProvider.swift
//  EatAPITests
//
//  Created by Krzysztof Jankowski on 24/03/2021.
//

import Combine
@testable import EatAPI

struct MockPostcodeProvider: PostcodeProvider {
    
    func getCurrentPostcode() -> AnyPublisher<String?, Never> {
        Just("E15 3LS")
            .eraseToAnyPublisher()
    }
}

