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
            KeyValueView(key: "alternative_rendition_type", link: mediaAlternativeRendition.rfcLink, value: "\(mediaAlternativeRendition.type)")
            KeyValueView(key: "alternative_rendition_group", link: mediaAlternativeRendition.rfcLink, value: mediaAlternativeRendition.group)
            KeyValueView(key: "alternative_rendition_name", link: mediaAlternativeRendition.rfcLink, value: mediaAlternativeRendition.name)
            KeyValueView(key: "alternative_rendition_language", link: mediaAlternativeRendition.rfcLink, value: mediaAlternativeRendition.language)
            KeyValueView(key: "alternative_rendition_URI", link: mediaAlternativeRendition.rfcLink, value: mediaAlternativeRendition.URI.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "alternative_rendition_defaultRendition", link: mediaAlternativeRendition.rfcLink, value: "\(mediaAlternativeRendition.defaultRendition)")
            KeyValueView(key: "alternative_rendition_autoselect", link: mediaAlternativeRendition.rfcLink, value: "\(mediaAlternativeRendition.autoselect)")
            Spacer()
        }
        .padding(20)
    }
}
