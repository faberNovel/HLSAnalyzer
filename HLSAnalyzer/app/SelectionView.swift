//
//  SelectionView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import SwiftUI
import backstage
import M3U8Parser

struct SelectionView: View {

    @ObservedObject var presenter: SelectionPresenter

    let selection: (_: M3U8URL) -> Void

    var body: some View {
        HStack {
            TextField("entry_placeholder", text: $presenter.entry)
                .disableAutocorrection(true)
            if let m3u8URL = presenter.m3u8URL {
                Button("load") { selection(m3u8URL) }
            } else {
                Button("load", action: {}).disabled(true)
            }
        }.padding(30)
    }
}

private struct OptionnalButton: View {

    let m3u8URL: M3U8URL?

    var body: some View {
        if let m3u8URL = self.m3u8URL {
            MainDependencyProvider.main.masterView(m3u8URL: m3u8URL)
        } else {
            EmptyView()
        }
    }
}
