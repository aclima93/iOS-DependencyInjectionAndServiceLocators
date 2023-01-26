//
//  ViewModel.swift
//  DependencyInjectionAndServiceLocators
//
//  Created by Antonio Lima on 23/01/2023.
//

import Foundation

// MARK: Naive ViewModel
// Uses a hardcoded dependency. 🔨

struct NaiveViewModel {

    private(set) var model: Model
    let service: Service = .singleton

    init(model: Model) {
        self.model = model
    }

    func getUpdatedValue() -> Bool {
        service.toggle(bool: model.boolProperty)
    }
}

// MARK: Meh DI ViewModel
// a.k.a Property Dependency Injection
//
// Expects a concrete dependency implementation.
// Expects the dependency to be injected at some point 🔮 through a property,
// otherwise it won't function properly. 🥫
// Having unrealistic expectations is the fastest way to a sad existence.
// (This also applies to code 🥲)

struct MehDiViewModel {

    private(set) var model: Model
    var service: Service?

    init(model: Model) {
        self.model = model
    }

    func getUpdatedValue() -> Bool {
        // forces us to return a default value, which is a business logic decision ⚠️
        service?.toggle(bool: model.boolProperty) ?? true
    }
}

// MARK: Good DI ViewModel
// Its dependencies are injected through the initialiser.
// Still relies on concrete implementation for service.

struct GoodDiViewModel {

    private(set) var model: Model
    let service: Service

    init(
        model: Model,
        service: Service
    ) {
        self.model = model
        self.service = service
    }

    func getUpdatedValue() -> Bool {
        service.toggle(bool: model.boolProperty)
    }
}

// MARK: Better DI ViewModel
// Its dependencies are injected through the initialiser,
// and they provide a default implementation.
// Relies on abstract protocol for service.

struct BetterDiViewModel {

    private(set) var model: Model
    let service: ServiceProtocol

    init(
        model: Model,
        service: ServiceProtocol = ServiceImplementation.singleton
    ) {
        self.model = model
        self.service = service
    }

    func getUpdatedValue() -> Bool {
        service.toggle(bool: model.boolProperty)
    }
}

// MARK: Best DI ViewModel
// Is bound by a protocol, enabling it to easily be mocked for testing purposes.
// Its dependencies are injected through the initialiser,
// and they provide a default implementation.

protocol DiViewModelRepresentable {

    var model: Model { get }
    var service: ServiceProtocol { get }

    func getUpdatedValue() -> Bool
}

struct DiViewModel: DiViewModelRepresentable {

    private(set) var model: Model
    let service: ServiceProtocol

    init(
        model: Model,
        service: ServiceProtocol = ServiceImplementation.singleton
    ) {
        self.model = model
        self.service = service
    }

    func getUpdatedValue() -> Bool {
        service.toggle(bool: model.boolProperty)
    }
}

// MARK: Service Locator DI Viewmodel

struct ServiceLocatorDiViewModel: DiViewModelRepresentable {

    private(set) var model: Model
    let service: ServiceProtocol

    init(
        model: Model,
        service: ServiceProtocol
    ) {
        self.model = model
        self.service = service
    }

    func getUpdatedValue() -> Bool {
        service.toggle(bool: model.boolProperty)
    }
}
