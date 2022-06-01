//
//  MediaPlaylist.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 11/12/2018.
//

import Foundation

public struct MediaPlaylist {

    public let resolution: Resolution?
    public let bandwidth: Int
    public let audio: String?
    public let codecs: String?
    public let path: String
    public let hadRelativePath: Bool

    public init(resolution: Resolution?,
                bandwidth: Int,
                audio: String?,
                codecs: String?,
                path: String) {
        self.init(
            resolution: resolution,
            bandwidth: bandwidth,
            audio: audio,
            codecs: codecs,
            path: path,
            hadRelativePath: URL(string: path)?.host == nil
        )
    }

    private init(resolution: Resolution?,
                 bandwidth: Int,
                 audio: String?,
                 codecs: String?,
                 path: String,
                 hadRelativePath: Bool) {
        self.resolution = resolution
        self.bandwidth = bandwidth
        self.audio = audio
        self.codecs = codecs
        self.path = path
        self.hadRelativePath = hadRelativePath
    }

    public func mediaPlaylist(withBaseURL baseURL: URL) -> MediaPlaylist? {
        guard
            let currentURL = URL(string: path),
            let nextURL = URL(
                string: currentURL.path,
                relativeTo: baseURL
            ) else {
                return nil
        }
        return mediaPlaylist(withURLString: nextURL.absoluteString)
    }

    // MARK: - Private

    private func mediaPlaylist(withURLString urlString: String) -> MediaPlaylist {
        return MediaPlaylist(
            resolution: resolution,
            bandwidth: bandwidth,
            audio: audio,
            codecs: codecs,
            path: urlString,
            hadRelativePath: hadRelativePath
        )
    }
}
