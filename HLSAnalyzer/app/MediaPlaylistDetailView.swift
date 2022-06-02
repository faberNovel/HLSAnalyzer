//
//  MediaPlaylistDetailView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import SwiftUI
import M3U8Parser
import backstage

struct MediaPlaylistDetailView: View {

    @ObservedObject var presenter: MediaPlaylistDetailPresenter

    var body: some View {
        StatefulView(
            error: $presenter.error,
            loading: $presenter.loading,
            viewModel: $presenter.viewModel,
            placeholderView: { Text("no_media_playlist_placeholder") },
            viewModelView: { MediaPlaylistDetailInternalView(sections: $0) }
        )
        .onAppear { [weak presenter] in
            presenter?.appearance()
        }
    }
}

struct MediaPlaylistDetailInternalView: View {

    let sections: [MediaPlaylistDetailSectionViewModel]

    var body: some View {
        NavigationView {
            List(sections, children: \.rows) { item in
                switch item.navigation {
                case .segment(let segment):
                    NavigationLink {
                        SegmentDetailView(segment: segment)
                    } label: {
                        KeyValueView(key: item.viewModel.key, value: item.viewModel.value)
                    }
                case .rows, .none:
                    KeyValueView(key: item.viewModel.key, value: item.viewModel.value)
                }
            }
            .frame(minWidth: 400)
        }
    }
}
