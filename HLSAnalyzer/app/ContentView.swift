//
//  SelectionView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 27/05/2022.
//

import SwiftUI
import backstage
import M3U8Parser

struct ContentView: View {

    @StateObject private var stateHolder = StateHolder()

    var body: some View {

        Group {
            switch stateHolder.state {
            case.empty:
                EmptyView()
            case .openURL:
                MainDependencyProvider.main.selectionView { stateHolder.state = .m3u8($0) }
            case .m3u8(let m3u8):
                MainDependencyProvider.main.masterView(m3u8URL: m3u8)
                    .frame(minWidth: 1200, minHeight: 400)
            }
        }
    }
}
