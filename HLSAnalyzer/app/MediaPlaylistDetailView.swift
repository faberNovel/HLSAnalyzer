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
        let binding = Binding<Bool> {
            presenter.error != nil
        } set: { _ in
            presenter.error = nil
        }
        Group {
            if let viewModel = presenter.viewModel {
                MediaPlaylistDetailInternalView(sections: viewModel)
            } else {
                Text("no_media_playlist_placeholder")
            }
        }
        .alert(presenter.error?.localizedDescription ?? "error", isPresented: binding) {}
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
