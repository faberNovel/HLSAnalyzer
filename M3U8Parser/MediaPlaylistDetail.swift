//
//  MediaPlaylistDetail.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 11/12/2018.
//

import Foundation

public struct MediaPlaylistDetail {
    public let extTag: String
    public let version: Int?
    public let targetDuration: Int?
    public let allowCache: Bool
    public let mediaSequence: Int?
    public let segments: [MediaSegment]

    public func mediaPlaylist(withPath path: String) -> MediaPlaylistDetail {
        return MediaPlaylistDetail(
            extTag: extTag,
            version: version,
            targetDuration: targetDuration,
            allowCache: allowCache,
            mediaSequence: mediaSequence,
            segments: segments.map {
                MediaSegment(
                    duration: $0.duration,
                    sequence: $0.sequence,
                    subrangeLength: $0.subrangeLength,
                    subrangeStart: $0.subrangeStart,
                    title: $0.title,
                    discontinuity: $0.discontinuity,
                    path: path + "/" +  $0.path
                )
            }
        )
    }
}
