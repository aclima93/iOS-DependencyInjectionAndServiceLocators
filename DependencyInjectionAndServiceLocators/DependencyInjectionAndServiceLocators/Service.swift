//
//  Service.swift
//  DependencyInjectionAndServiceLocators
//
//  Created by Antonio Lima on 23/01/2023.
//

import Foundation

// MARK: Naive Service
// A singleton that doesn't conform to any protocol 😱
// Cannot be reused and repurposed for testing easily.

class Service {

    // We usually call this `shared` or `default`,
    // this is just to be explicit.
    static let singleton = Service()

    func toggle(bool: Bool) -> Bool {
        !bool
    }
}

// MARK: Dependency Injection
// Make our singleton class conform to a protocol.

// Tip: The simplest way to get started on a protocol is to just list the existing method signatures. 🧠
protocol ServiceProtocol {
    func toggle(bool: Bool) -> Bool
}

class ServiceImplementation: ServiceProtocol {

    static let singleton = ServiceImplementation()

    func toggle(bool: Bool) -> Bool {
        !bool
    }
}

// MARK: Service Locator

class LocatableServiceImplementation: Serviceable, ServiceProtocol {

    required init() {}

    func toggle(bool: Bool) -> Bool {
        !bool
    }
}
