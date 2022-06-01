//
//  MediaPlaylistDetailPresenter.swift
//  backstage
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import core
import M3U8Parser

public class MediaPlaylistDetailPresenter: ObservableObject {

    private let mediaPlaylist: MediaPlaylist
    @Published public var viewModel: [MediaPlaylistDetailSectionViewModel]?
    @Published public var loading = false
    @Published public var error: Error?

    private var mediaPlaylistDetail: MediaPlaylistDetail? {
        didSet {
            viewModel = mediaPlaylistDetail.flatMap { MediaPlaylistDetailMapper(mediaPlaylist: mediaPlaylist, mediaPlaylistDetail: $0).map() }
        }
    }

    private let mediaPlaylistInteractor: MediaPlaylistInteractor

    public init(mediaPlaylist: MediaPlaylist, mediaPlaylistInteractor: MediaPlaylistInteractor) {
        self.mediaPlaylist = mediaPlaylist
        self.mediaPlaylistInteractor = mediaPlaylistInteractor
    }

    public func appearance() {
        Task { await loadData() }
    }

    @MainActor private func loadData() async {
        guard !loading else { return }
        loading = true
        do {
            self.mediaPlaylistDetail = try await mediaPlaylistInteractor.execute(mediaPlaylist: mediaPlaylist)
        } catch {
            self.error = error
            print(error)
        }
        loading = false
    }
}
