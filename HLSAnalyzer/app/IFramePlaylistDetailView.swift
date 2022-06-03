//
//  IFramePlaylistDetailView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import SwiftUI
import M3U8Parser

struct IFramePlaylistDetailView: View {

    let iFramePlaylist: IFramePlaylist

    var body: some View {
        VStack(spacing: 8) {
            KeyValueView(key: "iframe_playlist_bandwidth", value: "\(iFramePlaylist.bandwidth)")
            KeyValueView(key: "iframe_playlist_URI", value: iFramePlaylist.URI)
            KeyValueView(key: "iframe_playlist_resolution", value: iFramePlaylist.resolution?.stringValue)
            KeyValueView(key: "iframe_playlist_codecs", value: iFramePlaylist.codecs)
            Spacer()
        }
        .padding(20)
    }
}
