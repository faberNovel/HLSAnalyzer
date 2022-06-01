//
//  MediaPlaylistDetailMapper.swift
//  backstage
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import M3U8Parser

struct MediaPlaylistDetailMapper {

    let mediaPlaylist: MediaPlaylist
    let mediaPlaylistDetail: MediaPlaylistDetail

    func map() -> [MediaPlaylistDetailSectionViewModel] {
        MediaPlaylistMapper(mediaPlaylist: mediaPlaylist).map().map { $0.contravariant() }
        +
        [
            LeafKeyValueViewModel(key: "media_tag", value: mediaPlaylistDetail.extTag).contravariant(),
            LeafKeyValueViewModel(key: "media_version", value: mediaPlaylistDetail.version.flatMap { "\($0)" } ?? "_").contravariant(),
            LeafKeyValueViewModel(key: "media_target_duration", value: mediaPlaylistDetail.targetDuration.flatMap { "\($0)" } ?? "_").contravariant(),
            LeafKeyValueViewModel(key: "media_allow_cache", value: "\(mediaPlaylistDetail.allowCache)").contravariant(),
            LeafKeyValueViewModel(key: "media_media_sequence", value: mediaPlaylistDetail.mediaSequence.flatMap { "\($0)" } ?? "_").contravariant(),
            MediaPlaylistDetailSectionViewModel(
                key: "segments",
                value: "\(mediaPlaylistDetail.segments.count)",
                navigation: .rows(mediaPlaylistDetail.segments.map {
                    MediaPlaylistDetailSectionViewModel(
                        key: $0.path.readablePathName ,
                        value: $0.title,
                        navigation: .segment($0)
                    )
                })
            )
        ]
    }
}
