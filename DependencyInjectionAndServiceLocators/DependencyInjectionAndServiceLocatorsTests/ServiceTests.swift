//
//  ServiceTests.swift
//  DependencyInjectionAndServiceLocatorsTests
//
//  Created by Antonio Lima on 24/01/2023.
//

import XCTest
@testable import DependencyInjectionAndServiceLocators

final class ServiceTests: XCTestCase {

    func testService_TogglesBooleans() throws {

        let sut: ServiceImplementation = .init()
        XCTAssertTrue(sut.toggle(bool: false))
        XCTAssertFalse(sut.toggle(bool: true))
    }
}
