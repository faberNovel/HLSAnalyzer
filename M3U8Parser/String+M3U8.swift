//
//  String+M3U8.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 04/07/2019.
//

import Foundation

enum EXTPrefix {
    static let Comment = "#"
    static let Tag = Comment + "EXT"
    static let M3U = Tag + "M3U"
    static let Version = Tag + "-X-VERSION"
    static let SessionKey = Tag + "-X-SESSION-KEY"
    static let StreamInformation = Tag + "-X-STREAM-INF"
    static let IFrameStreamInformation = Tag + "-X-I-FRAME-STREAM-INF"
    static let AlternativeRendition = Tag + "-X-MEDIA"
    static let AllowCacheKey = Tag + "-X-ALLOW-CACHE"
    static let TargetDurationKey = Tag + "-X-TARGETDURATION"
    static let SequenceKey = Tag + "-X-MEDIA-SEQUENCE"
    static let SegmentDuration = Tag + "INF"
}

extension String {

    var isM3u8Tag: Bool {
        return hasPrefix(EXTPrefix.Tag)
    }

    func hasM3u8Prefix(_ prefix: String) -> Bool {
        return hasPrefix(prefix + ":") || self == prefix
    }
}
