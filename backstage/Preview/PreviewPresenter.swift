//
//  PreviewPresenter.swift
//  backstage
//
//  Created by Benjamin Lavialle on 05/07/2022.
//

import Foundation
import M3U8Parser

public class PreviewPresenter: ObservableObject {

    public let m3u8: M3U8URL

    public init(m3u8: M3U8URL) {
        self.m3u8 = m3u8
    }
}
