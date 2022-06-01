//
//  HLSNetworkRepository.swift
//  data
//
//  Created by Benjamin Lavialle on 27/05/2022.
//

import Foundation
import core
import M3U8Parser

public class HLSNetworkRepository: HLSRepository {

    private let session: URLSession

    private let m3u8Serializer = M3U8Serializer()

    public init(session: URLSession) {
        self.session = session
    }

    public func masterPlaylist(_ m3u8: M3U8URL) async throws -> MasterPlaylist {
        try m3u8Serializer.deserializeM3U8(from: try await session.data(from: m3u8.URL).0)
    }
}
