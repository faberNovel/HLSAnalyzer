//
//  HLSAnalyzerApp.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 27/05/2022.
//

import SwiftUI
import backstage
import M3U8Parser

@main
struct HLSAnalyzerApp: App {

    @Environment(\.openURL) var openURL

    var body: some Scene {
        WindowGroup {
            ContentView()
            .onAppear { NSWindow.allowsAutomaticWindowTabbing = false }
        }.commands {
            CommandGroup(replacing: .newItem) {
                Button("open_url") {
                    if let url = URL(string: "hlsanalyzer://openurl") {
                        openURL(url)
                    }
                }
            }
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "openurl"))
    }
}


class StateHolder: ObservableObject {

    enum State {
        case empty
        case openURL
        case m3u8(_: M3U8URL)
    }

    @Published public var state = State.openURL
}

struct Viewer: View {
    var body: some View {
        Text("Viewer")
    }
}
