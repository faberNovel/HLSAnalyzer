//
//  PresenterAssembly.swift
//  TEMPLATE
//
//  Created by Benjamin Lavialle on 30/11/16.
//
//

import Foundation
import Swinject
import backstage
import core

// swiftlint:disable force_unwrapping function_body_length superfluous_disable_command

class PresenterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SelectionPresenter.self) { _ in SelectionPresenter() }
        container.register(MasterPresenter.self) { r, m3u8URL in
            MasterPresenter(m3u8URL: m3u8URL, HLSInteractor: r.resolve(HLSInteractor.self)!)
        }
        container.register(MediaPlaylistDetailPresenter.self) { r, mediaPlaylist in
            MediaPlaylistDetailPresenter(mediaPlaylist: mediaPlaylist, mediaPlaylistInteractor: r.resolve(MediaPlaylistInteractor.self)!)
        }
        container.register(PreviewPresenter.self) { r, mediaPlaylist in
            PreviewPresenter(m3u8: mediaPlaylist)
        }
    }
}
