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
    let preview: (_: M3U8URL) -> Void

    var body: some View {
        HStack {
            TextField("entry_placeholder", text: $presenter.entry)
                .disableAutocorrection(true)
                .onSubmit { check(then: selection) }
            Button("load", action: { check(then: selection) }).disabled(presenter.m3u8URL == nil)
            Button("preview", action: { check(then: preview) }).disabled(presenter.m3u8URL == nil)
        }.padding(30)
    }

    private func check(then action: (_: M3U8URL) -> Void) {
        guard let m3u8URL = presenter.m3u8URL else { return }
        action(m3u8URL)
    }
}
