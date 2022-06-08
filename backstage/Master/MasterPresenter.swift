//
//  MasterPresenter.swift
//  backstage
//
//  Created by Benjamin Lavialle on 30/05/2022.
//

import Foundation
import core
import M3U8Parser

public class MasterPresenter: ObservableObject {

    private let m3u8URL: M3U8URL
    @Published public var viewModel: [MasterSectionViewModel]?
    @Published public var loading = false
    @Published public var error: Error?

    public var title: String { m3u8URL.URL.absoluteString }

    private var m3u8: MasterPlaylist? {
        didSet { viewModel = m3u8.flatMap { MasterMapper(m3u8URL: m3u8URL, masterPlaylist: $0).map() } }
    }

    private let HLSInteractor: HLSInteractor

    public init(m3u8URL: M3U8URL, HLSInteractor: HLSInteractor) {
        self.m3u8URL = m3u8URL
        self.HLSInteractor = HLSInteractor
    }

    public func appearance() {
        Task { await loadData() }
    }

    @MainActor private func loadData() async {
        guard !loading else { return }
        loading = true
        do {
            self.m3u8 = try await HLSInteractor.execute(m3u8URL: m3u8URL)
        } catch {
            self.error = error
        }
        loading = false
    }
}
