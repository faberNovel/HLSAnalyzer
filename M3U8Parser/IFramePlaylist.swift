//
//  IFramePlaylist.swift
//  Pods
//
//  Created by Benjamin Lavialle on 21/12/2018.
//

import Foundation

public struct IFramePlaylist {

    public let bandwidth: Int
    public let URI: String
    public let resolution: Resolution?
    public let codecs: String?

    public init(bandwidth: Int,
                URI: String,
                resolution: Resolution?,
                codecs: String?) {
        self.resolution = resolution
        self.bandwidth = bandwidth
        self.codecs = codecs
        self.URI = URI
    }
}
