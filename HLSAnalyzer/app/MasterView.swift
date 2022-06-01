//
//  MasterView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 30/05/2022.
//

import SwiftUI
import backstage
import M3U8Parser

struct MasterView: View {

    @ObservedObject var presenter: MasterPresenter

    var body: some View {
        let binding = Binding<Bool> {
            presenter.error != nil
        } set: { _ in
            presenter.error = nil
        }
        Group {
            if let viewModel = presenter.viewModel {
                MasterDetailView(title: presenter.title, sections: viewModel)
            } else {
                Text("no_m3u8_placeholder")
            }
        }
        .alert(presenter.error?.localizedDescription ?? "error", isPresented: binding) {}
        .onAppear { [weak presenter] in
            presenter?.appearance()
        }
    }
}

struct MasterDetailView: View {

    let title: String
    let sections: [MasterSectionViewModel]

    var body: some View {
        NavigationView {
            List(sections, children: \.rows) { item in
                switch item.navigation {
                case .iFramePlaylist(let iFramePlaylist):
                    NavigationLink {
                        IFramePlaylistDetailView(iFramePlaylist: iFramePlaylist)
                    } label: {
                        KeyValueView(key: item.viewModel.key, value: item.viewModel.value)
                    }
                case .mediaAlternativeRendition(let rendition):
                    NavigationLink {
                        MediaAlternativeRenditionDetailView(mediaAlternativeRendition: rendition)
                    } label: {
                        KeyValueView(key: item.viewModel.key, value: item.viewModel.value)
                    }
                case .mediaPlaylist(let mediaPlaylist):
                    NavigationLink {
                        MainDependencyProvider.main.mediaPlaylistDetailView(mediaPlaylist: mediaPlaylist)
                    } label: {
                        KeyValueView(key: item.viewModel.key, value: item.viewModel.value)
                    }
                case .rows, .none:
                    KeyValueView(key: item.viewModel.key, value: item.viewModel.value)
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth: 400)
        }.navigationTitle(title)
    }
}

struct KeyValueView: View {

    let key: String
    let value: String?

    var body: some View {
        HStack {
            Text(key).font(.body.bold())
            if let value = value {
                Spacer()
                Text(value).truncationMode(.head).lineLimit(1).foregroundColor(.gray)
            }
        }
    }
}
