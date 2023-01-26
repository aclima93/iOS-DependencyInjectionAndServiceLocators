//
//  ServiceLocator.swift
//  DependencyInjectionAndServiceLocatorsTests
//
//  Created by Antonio Lima on 24/01/2023.
//

import XCTest
@testable import DependencyInjectionAndServiceLocators

final class ServiceLocatorTests: XCTestCase {

    var sut: ServiceLocator = .shared

    override func tearDownWithError() throws {
        sut.unregisterAll()
    }

    // MARK: Happy Paths

    func testServiceLocator_Initially_IsEmpty() throws {
        XCTAssertEqual(sut.getRegisteredServiceNames(), [])
    }

    func testServiceLocator_RegisterService_ShouldStoreService() throws {

        let service = MockService()
        let serviceName = try sut.register(service: service)

        XCTAssertEqual(serviceName, "MockService")
        XCTAssertEqual(sut.getRegisteredServiceNames(), [serviceName])
    }

    func testServiceLocator_LocateRegisteredService_ShouldReturnService() throws {

        let service = MockService()
        try sut.register(service: service)

        let locatedService: MockService = try sut.get()
        XCTAssertEqual(service, locatedService)
    }

    func testServiceLocator_UnregisterService_ShouldRemoveService() throws {

        let service = MockService()
        try sut.register(service: service)

        try sut.unregister(MockService.self)
        XCTAssertEqual(sut.getRegisteredServiceNames(), [])
    }

    func testServiceLocator_GetOrRegisterService_ShouldGetService() throws {

        let service = MockLocatableService()
        try sut.register(service: service)

        let locatedService = sut.getOrRegister(MockLocatableService.self)
        XCTAssertEqual(locatedService, service)
    }

    func testServiceLocator_GetOrRegisterService_ShouldRegisterService() throws {

        let locatedService = sut.getOrRegister(MockLocatableService.self)
        XCTAssertNotNil(locatedService)
    }

    // MARK: Error handling

    func testServiceLocator_RegisterDuplicateService_ShouldThrowError() throws {

        let service = MockService()
        try sut.register(service: service)

        let errorExpectation = expectation(description: "errorExpectation")

        do {
            let duplicateService = MockService()
            try sut.register(service: duplicateService)
        } catch ServiceLocator.Error.duplicateService("MockService") {
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 0.1)
    }

    func testServiceLocator_WithUnregisteredService_ShouldThrowError() throws {

        let errorExpectation = expectation(description: "errorExpectation")

        do {
            let _: MockService = try sut.get()
        } catch ServiceLocator.Error.inexistentService("MockService") {
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 0.1)
    }

    func testServiceLocator_WithRegisteredServiceOfAnotherType_ShouldThrowError() throws {

        let service = MockService()
        try sut.register(service: service, name: "Service")

        let errorExpectation = expectation(description: "errorExpectation")

        do {
            let _: AnotherMockService = try sut.get(name: "Service")
        } catch ServiceLocator.Error.typeMismatch("Service") {
            errorExpectation.fulfill()
        }

        wait(for: [errorExpectation], timeout: 0.1)
    }
}

private extension ServiceLocatorTests {

    class MockService: Equatable {
        let id: UUID = .init()

        static func == (lhs: MockService, rhs: MockService) -> Bool {
            lhs.id == rhs.id
        }
    }

    class AnotherMockService: Equatable {
        let id: UUID = .init()

        static func == (lhs: AnotherMockService, rhs: AnotherMockService) -> Bool {
            lhs.id == rhs.id
        }
    }

    class MockLocatableService: Serviceable, Equatable {
        let id: UUID = .init()

        required init() {}

        static func == (lhs: MockLocatableService, rhs: MockLocatableService) -> Bool {
            lhs.id == rhs.id
        }
    }
}
