//
//  MasterSectionViewModel.swift
//  backstage
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import M3U8Parser

public typealias MasterSectionViewModel = NavigableKeyValueViewModel<MasterPlaylistNavigation>

public enum MasterPlaylistNavigation: KeyValueNavigation {

    case mediaAlternativeRendition(_: MediaAlternativeRendition)
    case mediaPlaylist(_: MediaPlaylist)
    case iFramePlaylist(_: IFramePlaylist)
    case rows(_: [MasterSectionViewModel])

    public var rows: [MasterSectionViewModel]? {
        guard case let .rows(rows) = self else { return nil }
        return rows
    }
}
