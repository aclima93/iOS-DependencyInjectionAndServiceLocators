//
//  ViewModelTests.swift
//  DependencyInjectionAndServiceLocatorsTests
//
//  Created by Antonio Lima on 24/01/2023.
//

import XCTest
@testable import DependencyInjectionAndServiceLocators

final class ViewModelTests: XCTestCase {

    func testViewModel_WithTrueModelAndDefaultService_TogglesBoolean() throws {

        let model: Model = .init(boolProperty: true)
        let sut: DiViewModel = .init(
            model: model
        )

        XCTAssertFalse(sut.getUpdatedValue())
    }

    func testViewModel_WithFalseModelAndDefaultService_TogglesBoolean() throws {

        let model: Model = .init(boolProperty: false)
        let sut: DiViewModel = .init(
            model: model
        )

        XCTAssertTrue(sut.getUpdatedValue())
    }

    // MARK: Service Stubs

    func testViewModel_WithServiceStubSetToTrue_ReturnsTrue() throws {

        let model: Model = .init(boolProperty: true)
        let service: MockServiceImplementation = .init()
        let sut: DiViewModel = .init(
            model: model,
            service: service
        )

        let serviceToggleExpectation = expectation(description: "serviceToggleExpectation")
        service.toggleClosure = { _ in
            serviceToggleExpectation.fulfill()
            return true
        }

        XCTAssertTrue(sut.getUpdatedValue())

        wait(for: [serviceToggleExpectation], timeout: 0.1)
    }

    func testViewModel_WithServiceStubSetToFalse_ReturnsTrue() throws {

        let model: Model = .init(boolProperty: true)
        let service: MockServiceImplementation = .init()
        let sut: DiViewModel = .init(
            model: model,
            service: service
        )

        let serviceToggleExpectation = expectation(description: "serviceToggleExpectation")
        service.toggleClosure = { _ in
            serviceToggleExpectation.fulfill()
            return false
        }

        XCTAssertFalse(sut.getUpdatedValue())

        wait(for: [serviceToggleExpectation], timeout: 0.1)
    }
}
