//
//  MediaPlaylistMapper.swift
//  backstage
//
//  Created by Benjamin Lavialle on 01/06/2022.
//

import Foundation
import M3U8Parser

struct MediaPlaylistMapper {

    let mediaPlaylist: MediaPlaylist

    func map() -> [LeafKeyValueViewModel] {
        [
            LeafKeyValueViewModel(key: "media_resolution", value: mediaPlaylist.resolution?.stringValue),
            LeafKeyValueViewModel(key: "media_bandwidth", value: "\(mediaPlaylist.bandwidth)"),
            LeafKeyValueViewModel(key: "media_audio", value: mediaPlaylist.audio),
            LeafKeyValueViewModel(key: "media_codecs", value: mediaPlaylist.codecs),
            LeafKeyValueViewModel(key: "media_path", value: mediaPlaylist.path),
            LeafKeyValueViewModel(key: "media_has_relative_path", value: mediaPlaylist.hadRelativePath ? "yes" : "no"),
        ]
    }
}

