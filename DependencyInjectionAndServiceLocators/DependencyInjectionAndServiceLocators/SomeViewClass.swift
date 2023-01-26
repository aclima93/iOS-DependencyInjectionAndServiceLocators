//
//  View.swift
//  DependencyInjectionAndServiceLocators
//
//  Created by Antonio Lima on 23/01/2023.
//

import Foundation
import UIKit

class SomeViewClass {

    private(set) var viewModel: DiViewModelRepresentable

    init(viewModel: DiViewModelRepresentable) {
        self.viewModel = viewModel
    }

    init() {

        viewModel = ServiceLocatorDiViewModel.init(
            model: .init(boolProperty: true),
            service: ServiceLocator.shared.getOrRegister(LocatableServiceImplementation.self)
        )
    }
}
