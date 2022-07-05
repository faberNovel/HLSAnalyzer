//
//  MainDependencyProvider.swift
//  TEMPLATE
//
//  Created by Gaétan Zanella on 23/11/21.
//
//

import Swinject
import backstage
import SwiftUI
import M3U8Parser

// swiftlint:disable force_unwrapping line_length superfluous_disable_command

class MainDependencyProvider {

    public static let main = MainDependencyProvider()

    private let presenterAssembler: Assembler

    init() {
        presenterAssembler = Assembler([
            HelperAssembly(),
            RepositoryAssembly(),
            InteractorAssembly(),
            PresenterAssembly(),
        ])
    }

    // MARK: - Presenters

    func selectionView(_ selection: @escaping (M3U8URL) -> Void, preview: @escaping (M3U8URL) -> Void) -> SelectionView {
        SelectionView(presenter: presenterAssembler.resolver.resolve(SelectionPresenter.self)!, selection: selection, preview: preview)
    }

    func masterView(m3u8URL: M3U8URL) -> MasterView {
        MasterView(presenter: presenterAssembler.resolver.resolve(MasterPresenter.self, argument: m3u8URL)!)
    }

    func mediaPlaylistDetailView(mediaPlaylist: MediaPlaylist) -> MediaPlaylistDetailView {
        MediaPlaylistDetailView(presenter: presenterAssembler.resolver.resolve(MediaPlaylistDetailPresenter.self, argument: mediaPlaylist)!)
    }

    func previewView(m3u8URL: M3U8URL) -> PreviewView {
        PreviewView(presenter: presenterAssembler.resolver.resolve(PreviewPresenter.self, argument: m3u8URL)!)
    }
}
