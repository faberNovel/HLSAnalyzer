//
//  SelectionPresenter.swift
//  backstage
//
//  Created by Benjamin Lavialle on 27/05/2022.
//

import Foundation
import M3U8Parser

public class SelectionPresenter: ObservableObject {

    @Published public var entry = "https://artesimulcast.akamaized.net/hls/live/2031003/artelive_fr/index.m3u8" {
        willSet {
            m3u8URL = URL(string: newValue).flatMap { M3U8URL(URL:$0) }
        }
    }
    @Published public private(set) var m3u8URL: M3U8URL?

    public init() {}
}
