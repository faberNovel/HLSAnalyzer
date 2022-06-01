//
//  HLSRepository.swift
//  core
//
//  Created by Benjamin Lavialle on 27/05/2022.
//

import Foundation
import M3U8Parser

public protocol HLSRepository {
    func masterPlaylist(_ m3u8: M3U8URL) async throws -> MasterPlaylist
}
