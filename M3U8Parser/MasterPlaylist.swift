//
//  MasterPlaylist.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 11/12/2018.
//

import Foundation

public struct MasterPlaylist {
    public let extTag: String
    public let version: Int
    public let sessionKey: Key?
    public let mediaAlternativeRenditions: [MediaAlternativeRendition]
    public let mediaPlaylists: [MediaPlaylist]
    public let iFramePlaylists: [IFramePlaylist]

    public init(extTag: String,
                version: Int,
                sessionKey: Key?,
                mediaAlternativeRenditions: [MediaAlternativeRendition],
                mediaPlaylists: [MediaPlaylist],
                iFramePlaylists: [IFramePlaylist]) {
        self.extTag = extTag
        self.version = version
        self.sessionKey = sessionKey
        self.mediaAlternativeRenditions = mediaAlternativeRenditions
        self.mediaPlaylists = mediaPlaylists
        self.iFramePlaylists = iFramePlaylists
    }
}
