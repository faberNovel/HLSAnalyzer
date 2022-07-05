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
            LeafKeyValueViewModel(
                key: "media_tag",
                link: mediaPlaylistDetail.tagRfcLink,
                value: mediaPlaylistDetail.extTag
            ).contravariant(),
            LeafKeyValueViewModel(
                key: "media_version",
                link: mediaPlaylistDetail.versionRfcLink,
                value: mediaPlaylistDetail.version.flatMap { "\($0)" } ?? "_"
            ).contravariant(),
            LeafKeyValueViewModel(
                key: "media_target_duration",
                link: mediaPlaylistDetail.targetDurationRfcLink,
                value: mediaPlaylistDetail.targetDuration.flatMap { "\($0)" } ?? "_"
            ).contravariant(),
            LeafKeyValueViewModel(
                key: "media_allow_cache",
                value: "\(mediaPlaylistDetail.allowCache)"
            ).contravariant(),
            LeafKeyValueViewModel(
                key: "media_media_sequence",
                link: mediaPlaylistDetail.mediaSequenceRfcLink,
                value: mediaPlaylistDetail.mediaSequence.flatMap { "\($0)" } ?? "_"
            ).contravariant(),
            MediaPlaylistDetailSectionViewModel(
                key: "segments",
                value: "\(mediaPlaylistDetail.segments.count)",
                navigation: .rows(mediaPlaylistDetail.segments.map {
                    MediaPlaylistDetailSectionViewModel(
                        key: $0.path.readablePathName ,
                        link: mediaPlaylistDetail.segmentsRfcLink,
                        value: $0.title,
                        navigation: .segment($0)
                    )
                })
            )
        ]
    }
}
