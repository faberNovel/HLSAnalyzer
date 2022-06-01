//
//  RepositoryAssembly.swift
//  TEMPLATE
//
//  Created by Benjamin Lavialle on 30/11/16.
//
//

import Foundation
import Swinject
import core
import data

// swiftlint:disable force_unwrapping function_body_length superfluous_disable_command

class RepositoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HLSRepository.self) { r in HLSNetworkRepository(session: r.resolve(URLSession.self)!) }
        container.register(MediaPlaylistRepository.self) { r in MediaPlaylistNetworkRepository(session: r.resolve(URLSession.self)!) }
    }
}
