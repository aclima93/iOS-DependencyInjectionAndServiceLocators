//
//  MockDiViewModel.swift
//  DependencyInjectionAndServiceLocatorsTests
//
//  Created by Antonio Lima on 24/01/2023.
//

import Foundation
@testable import DependencyInjectionAndServiceLocators

// Now we can even mock the View model,
// which can be handy when unit testing UI behaviour without using expensive End-to-End tests. 💪

struct MockDiViewModel: DiViewModelRepresentable {

    static let `default` = {
        var mock = MockDiViewModel()

        mock.getUpdatedValueClosure = {
            mock.service.toggle(bool: mock.model.boolProperty)
        }

        return mock
    }()

    private(set) var model: Model
    let service: ServiceProtocol

    init(
        model: Model = .init(boolProperty: true),
        service: ServiceProtocol = MockServiceImplementation.default
    ) {
        self.model = model
        self.service = service
    }

    var getUpdatedValueClosure: (() -> Bool)!
    func getUpdatedValue() -> Bool {
        getUpdatedValueClosure()
    }
}
