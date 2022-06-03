//
//  DetailPlaylistView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import SwiftUI
import M3U8Parser

struct MediaAlternativeRenditionDetailView: View {

    let mediaAlternativeRendition: MediaAlternativeRendition

    var body: some View {
        VStack(spacing: 8) {
            KeyValueView(key: "alternative_rendition_type", value: "\(mediaAlternativeRendition.type)")
            KeyValueView(key: "alternative_rendition_group", value: mediaAlternativeRendition.group)
            KeyValueView(key: "alternative_rendition_name", value: mediaAlternativeRendition.name)
            KeyValueView(key: "alternative_rendition_language", value: mediaAlternativeRendition.language)
            KeyValueView(key: "alternative_rendition_URI", value: mediaAlternativeRendition.URI.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "alternative_rendition_defaultRendition", value: "\(mediaAlternativeRendition.defaultRendition)")
            KeyValueView(key: "alternative_rendition_autoselect", value: "\(mediaAlternativeRendition.autoselect)")
            Spacer()
        }
        .padding(20)
    }
}
