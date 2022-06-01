//
//  HelperAssembly.swift
//  TEMPLATE
//
//  Created by Benjamin Lavialle on 30/11/16.
//
//

import Foundation
import Swinject

// swiftlint:disable force_unwrapping function_body_length superfluous_disable_command

class HelperAssembly: Assembly {

    func assemble(container: Container) {
        container.register(URLSession.self) { _ in URLSession.shared }
    }
}
