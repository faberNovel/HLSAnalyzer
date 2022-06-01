//
//  MasterMapper.swift
//  backstage
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import M3U8Parser

struct MasterMapper {

    let m3u8URL: M3U8URL
    let masterPlaylist: MasterPlaylist

    func map() -> [MasterSectionViewModel] {
        [
            MasterSectionViewModel(key: "master_tag", value: masterPlaylist.extTag),
            MasterSectionViewModel(key: "master_version", value: String(masterPlaylist.version)),
            masterPlaylist.sessionKeySectionViewModel,
            MasterSectionViewModel(
                key: "alternative_renditions",
                value: "\(masterPlaylist.mediaAlternativeRenditions.count)",
                navigation: masterPlaylist.mediaAlternativeRenditions.count > 0
                ? .rows(masterPlaylist.mediaAlternativeRenditions.map {
                    MasterSectionViewModel(
                        key: $0.name,
                        value: $0.URI ?? "_",
                        navigation: .mediaAlternativeRendition($0)
                    )

                })
                : .none
            ),
            MasterSectionViewModel(
                key: "media_playlists",
                value: "\(masterPlaylist.mediaPlaylists.count)",
                navigation: masterPlaylist.mediaPlaylists.count > 0
                ? .rows(masterPlaylist.mediaPlaylists.map {
                    MasterSectionViewModel(
                        key: $0.resolution?.stringValue ?? "unknown_resolution",
                        value: $0.path,
                        navigation: .mediaPlaylist($0.hadRelativePath ? ($0.mediaPlaylist(withBaseURL: m3u8URL.URL) ?? $0) : $0)
                    )
                })
                : .none
            ),
            MasterSectionViewModel(
                key: "iframe_playlist",
                value: "\(masterPlaylist.iFramePlaylists.count)",
                navigation: masterPlaylist.iFramePlaylists.count > 0
                ? .rows(masterPlaylist.iFramePlaylists.map { MasterSectionViewModel(key: "\($0.bandwidth)", value: $0.URI) })
                : .none
            )
        ]
    }
}

private extension MasterPlaylist {

    var sessionKeySectionViewModel: MasterSectionViewModel {
        if let sessionKey = sessionKey {
            return MasterSectionViewModel(
                key: "session_key",
                value: "",
                navigation: .rows([
                    MasterSectionViewModel(key: "session_key", value: ""),
                    MasterSectionViewModel(key: "session_key_method", value: sessionKey.method.rawValue),
                    MasterSectionViewModel(key: "session_key_type", value: sessionKey.playlistType.stringValue),
                    MasterSectionViewModel(key: "session_key_uri", value: sessionKey.URI),
                    MasterSectionViewModel(key: "session_key_iv", value: sessionKey.IV),
                    MasterSectionViewModel(key: "session_key_key_format", value: sessionKey.keyFormat),
                    MasterSectionViewModel(key: "session_key_key_format_version", value: sessionKey.keyFormatVersion)
                ])
            )
        } else {
            return MasterSectionViewModel(key: "session_key", value: "no_session_key")
        }
    }

}

private extension Key.PlaylistType {

    var stringValue: String {
        switch self {
        case .detail:
            return "session_key_type_detail"
        case .master:
            return "session_key_type_master"
        }
    }
}
