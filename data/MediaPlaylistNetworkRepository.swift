//
//  MediaPlaylistNetworkRepository.swift
//  data
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import core
import M3U8Parser

public class MediaPlaylistNetworkRepository: MediaPlaylistRepository {

    private let session: URLSession

    private let mediaPlaylistDetailSerializer = MediaPlaylistDetailSerializer()

    public init(session: URLSession) {
        self.session = session
    }

    public func mediaPlaylistDetail(_ mediaPlaylist: MediaPlaylist) async throws -> MediaPlaylistDetail {
        guard let url = URL(string: mediaPlaylist.path) else { throw M3U8Serializer.Error.missingURL }
        return try mediaPlaylistDetailSerializer.deserializeM3U8(from: try await session.data(from: url).0)
    }
}
