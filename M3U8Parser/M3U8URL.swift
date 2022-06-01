//
//  M3U8URL.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 07/12/2018.
//

import Foundation

public struct M3U8URL: Hashable {

    public let URL: URL

    public init?(URL: URL) {
        guard URL.pathExtension == "m3u8" else { return nil }
        self.URL = URL
    }
}
