//
//  HLSInteractor.swift
//  core
//
//  Created by Benjamin Lavialle on 27/05/2022.
//

import Foundation
import M3U8Parser

public class HLSInteractor {

    private let HLSRepository: HLSRepository

    public init(HLSRepository: HLSRepository) {
        self.HLSRepository = HLSRepository
    }

    public func execute(m3u8URL: M3U8URL) async throws ->  MasterPlaylist {
        try await HLSRepository.masterPlaylist(m3u8URL)
    }
}
