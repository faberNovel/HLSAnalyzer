//
//  MediaPlaylistDetailSectionViewModel.swift
//  backstage
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import M3U8Parser

public typealias MediaPlaylistDetailSectionViewModel = NavigableKeyValueViewModel<MediaPlaylistDetailNavigation>

public enum MediaPlaylistDetailNavigation: KeyValueNavigation {

    case segment(_: MediaSegment)
    case rows(_: [MediaPlaylistDetailSectionViewModel])

    public var rows: [MediaPlaylistDetailSectionViewModel]? {
        guard case let .rows(rows) = self else { return nil }
        return rows
    }
}
