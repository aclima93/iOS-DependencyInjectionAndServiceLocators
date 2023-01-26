//
//  ModelTests.swift
//  DependencyInjectionAndServiceLocatorsTests
//
//  Created by Antonio Lima on 23/01/2023.
//

import XCTest
@testable import DependencyInjectionAndServiceLocators

// Note: Too granular, we usually avoid going this deep as it just makes the whole test suite brittle to change
final class ModelTests: XCTestCase {

    func testModel_InitialisedToTrue_RemainsTrue() throws {

        let sut = Model(boolProperty: true)
        XCTAssertTrue(sut.boolProperty)
    }

    func testModel_InitialisedToFalse_RemainsFalse() throws {

        let sut = Model(boolProperty: false)
        XCTAssertFalse(sut.boolProperty)
    }
}
