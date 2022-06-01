//
//  MediaPlaylistDetailSerializer.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 03/07/2019.
//

import Foundation


public struct MediaPlaylistDetailSerializer {

    private let segmentSerializer = MediaSegmentSerializer()

    public init() {}

    // MARK: - M3U8Serializer

    public func deserializeM3U8(from m3u8Data: M3U8Data) throws -> MediaPlaylistDetail {
        guard let iterator = m3u8Data.lineIterator() else { throw M3U8Serializer.Error.missingData }
        var currentExtInfLine: String?
        var segments: [MediaSegment] = []
        var extTagString: String?
        var version = 1
        var targetDuration: Int?
        var mediaSequence: Int?
        var allowCache = false
        iterator.forEach { line in
            if line.isEmpty {
            } else if line.isM3u8Tag {
                if line.hasPrefix(EXTPrefix.M3U) {
                    extTagString = line
                } else if line.hasM3u8Prefix(EXTPrefix.Version) {
                    if let versionInt = Int(
                        line.replacingOccurrences(of: EXTPrefix.Version + ":", with: "")
                        ) {
                        version = versionInt
                    }
                } else if line.hasM3u8Prefix(EXTPrefix.TargetDurationKey) {
                    if let targetDurationInt = Int(
                        line.replacingOccurrences(of: EXTPrefix.TargetDurationKey + ":", with: "")
                        ) {
                        targetDuration = targetDurationInt
                    }
                } else if line.hasM3u8Prefix(EXTPrefix.SequenceKey) {
                    if let mediaSequenceInt = Int(
                        line.replacingOccurrences(of: EXTPrefix.SequenceKey + ":", with: "")
                        ) {
                        mediaSequence = mediaSequenceInt
                    }
                } else if line.hasM3u8Prefix(EXTPrefix.AllowCacheKey) {
                    allowCache = line.replacingOccurrences(of: EXTPrefix.SequenceKey + ":", with: "") == "YES"
                } else if line.hasM3u8Prefix(EXTPrefix.SegmentDuration) {
                    currentExtInfLine = line
                }
            } else if line.hasM3u8Prefix(EXTPrefix.Comment) {
            } else if let extInfString = currentExtInfLine {
                let extInfPath = line
                if
                    let segment = segmentSerializer.deserializeMediaSegment(
                        fromExtInfString: extInfString,
                        path: extInfPath
                    ) {
                    segments.append(segment)
                }
                currentExtInfLine = nil
            }
        }
        guard
            let extTag = extTagString
            else {
                throw M3U8Serializer.Error.missingM3UTag
        }

        return MediaPlaylistDetail(
            extTag: extTag,
            version: version,
            targetDuration: targetDuration,
            allowCache: allowCache,
            mediaSequence: mediaSequence,
            segments: segments
        )
    }

    func serialize<T: M3U8Data>(_ detailPlaylist: MediaPlaylistDetail) -> T? {
        var string = detailPlaylist.extTag + "\n"
        string += EXTPrefix.Version + ":\(detailPlaylist.version ?? 1)" + "\n"
        if let targetDuration = detailPlaylist.targetDuration {
            string += EXTPrefix.TargetDurationKey + ":\(targetDuration)\n"
        }
        string += EXTPrefix.AllowCacheKey + ":\(detailPlaylist.allowCache ? "YES" : "NO")\n"
        if let sequence = detailPlaylist.mediaSequence {
            string += EXTPrefix.SequenceKey + ":\(sequence)\n"
        }
        string = detailPlaylist
            .segments
            .map { segmentSerializer.serialize($0) }
            .reduce(string) { $0 + ($0.isEmpty ? "" : "\n") + $1 }
        return T(string: string)
    }
}

private extension M3U8Data {
    func lineIterator() -> IndexingIterator<[String]>? {
        return stringValue?.components(separatedBy: CharacterSet.newlines).makeIterator()
    }
}
