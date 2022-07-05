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
            MasterSectionViewModel(
                key: "master_tag",
                link: masterPlaylist.tagRfcLink,
                value: masterPlaylist.extTag
            ),
            MasterSectionViewModel(
                key: "master_version",
                link: masterPlaylist.versionRfcLink,
                value: String(masterPlaylist.version)
            ),
            masterPlaylist.sessionKeySectionViewModel,
            MasterSectionViewModel(
                key: "alternative_renditions",
                link: masterPlaylist.alternativeRenditionRfcLink,
                value: "\(masterPlaylist.mediaAlternativeRenditions.count)",
                navigation: masterPlaylist.mediaAlternativeRenditions.count > 0
                ? .rows(masterPlaylist.mediaAlternativeRenditions.map {
                    MasterSectionViewModel(
                        key: $0.name,
                        value: $0.URI?.readablePathName ?? "_",
                        navigation: .mediaAlternativeRendition($0)
                    )

                })
                : .none
            ),
            MasterSectionViewModel(
                key: "media_playlists",
                link: masterPlaylist.mediaPlaylistsRfcLink,
                value: "\(masterPlaylist.mediaPlaylists.count)",
                navigation: masterPlaylist.mediaPlaylists.count > 0
                ? .rows(masterPlaylist.mediaPlaylists.map {
                    MasterSectionViewModel(
                        key: $0.resolution?.stringValue ?? "unknown_resolution",
                        value: $0.path.readablePathName,
                        navigation: .mediaPlaylist($0.hadRelativePath ? ($0.mediaPlaylist(withBaseURL: m3u8URL.URL) ?? $0) : $0)
                    )
                })
                : .none
            ),
            MasterSectionViewModel(
                key: "iframe_playlist",
                link: masterPlaylist.iFramePlaylistsRfcLink,
                value: "\(masterPlaylist.iFramePlaylists.count)",
                navigation: masterPlaylist.iFramePlaylists.count > 0
                ? .rows(masterPlaylist.iFramePlaylists.map { MasterSectionViewModel(key: "\($0.bandwidth)", value: $0.URI.readablePathName) })
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
                link: sessionKeyRfclink,
                value: "",
                navigation: .rows([
                    MasterSectionViewModel(
                        key: "session_key_method",
                        link: sessionKeyMethodRfclink,
                        value: sessionKey.method.rawValue
                    ),
                    MasterSectionViewModel(
                        key: "session_key_type",
                        value: sessionKey.playlistType.stringValue
                    ),
                    MasterSectionViewModel(
                        key: "session_key_uri",
                        link: sessionKeyURIRfclink,
                        value: sessionKey.URI
                    ),
                    MasterSectionViewModel(
                        key: "session_key_iv",
                        link: sessionKeyIVRfclink,
                        value: sessionKey.IV
                    ),
                    MasterSectionViewModel(
                        key: "session_key_key_format",
                        link: sessionKeyKeyFormatRfclink,
                        value: sessionKey.keyFormat
                    ),
                    MasterSectionViewModel(
                        key: "session_key_key_format_version",
                        link: sessionKeyKeyFormatVersionRfclink,
                        value: sessionKey.keyFormatVersion
                    )
                ])
            )
        } else {
            return MasterSectionViewModel(
                key: "session_key",
                link: sessionKeyRfclink,
                value: NSLocalizedString("no_session_key", comment: "")
            )
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
