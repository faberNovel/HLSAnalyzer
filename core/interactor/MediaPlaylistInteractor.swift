//
//  MediaPlaylistInteractor.swift
//  core
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import M3U8Parser

public class MediaPlaylistInteractor {

    private let mediaPlaylistRepository: MediaPlaylistRepository

    public init(mediaPlaylistRepository: MediaPlaylistRepository) {
        self.mediaPlaylistRepository = mediaPlaylistRepository
    }

    public func execute(mediaPlaylist: MediaPlaylist) async throws ->  MediaPlaylistDetail {
        try await mediaPlaylistRepository.mediaPlaylistDetail(mediaPlaylist)
    }
}
