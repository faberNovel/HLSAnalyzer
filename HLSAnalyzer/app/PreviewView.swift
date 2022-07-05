//
//  PreviewView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 05/07/2022.
//

import Foundation
import SwiftUI
import AVKit
import backstage

struct PreviewView: View {

    @ObservedObject var presenter: PreviewPresenter
    @State private var player: AVPlayer

    init(presenter: PreviewPresenter) {
        self.presenter = presenter
        self.player = AVPlayer(url: presenter.m3u8.URL)
    }

    var body: some View {
        VideoPlayer(player: player).onAppear { player.play()}
    }
}
