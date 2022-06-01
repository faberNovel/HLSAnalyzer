//
//  InteractorAssembly.swift
//  TEMPLATE
//
//  Created by Benjamin Lavialle on 30/11/16.
//
//

import Foundation
import Swinject
import core

// swiftlint:disable force_unwrapping function_body_length superfluous_disable_command

class InteractorAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HLSInteractor.self) { r in HLSInteractor(HLSRepository: r.resolve(HLSRepository.self)!) }
        container.register(MediaPlaylistInteractor.self) { r in MediaPlaylistInteractor(mediaPlaylistRepository: r.resolve(MediaPlaylistRepository.self)!) }
    }
}
