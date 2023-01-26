//
//  MockServices.swift
//  DependencyInjectionAndServiceLocatorsTests
//
//  Created by Antonio Lima on 24/01/2023.
//

import Foundation
@testable import DependencyInjectionAndServiceLocators

// MARK: Naive DI testing
// Enables us to stub our implementation for testing purposes 🙌

class NaiveStubServiceImplementation: ServiceProtocol {

    func toggle(bool: Bool) -> Bool {
        true
    }
}

// Doesn't allow us to mock the inner workings without replicating the entirety of the implementation 😞

class NaiveStub2ServiceImplementation: ServiceProtocol {

    func toggle(bool: Bool) -> Bool {
        false
    }
}


// MARK: Proper DI testing
// Enables us to mock our implementations for testing purposes.

class MockServiceImplementation: ServiceProtocol {

    // a default accessor for easy mocking
    static let `default` = {
        let mock = MockServiceImplementation()

        mock.toggleClosure = { _ in true }

        return mock
    }()

    // A simple but accessible way of customising the behaviour, without having to define instances entirely.
    // Note: it's force-unwrapped because it will only be used in a testing environment,
    // and we want things to break when done wrong!
    var toggleClosure: ((Bool) -> Bool)!
    func toggle(bool: Bool) -> Bool {
        toggleClosure(bool)
    }
}
