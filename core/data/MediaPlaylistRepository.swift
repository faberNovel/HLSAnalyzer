//
//  MediaPlaylistRepository.swift
//  core
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import M3U8Parser

public protocol MediaPlaylistRepository {
    func mediaPlaylistDetail(_ mediaPlaylist: MediaPlaylist) async throws -> MediaPlaylistDetail
}
