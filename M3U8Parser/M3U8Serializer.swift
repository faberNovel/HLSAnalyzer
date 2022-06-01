//
//  M3U8Serializer.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 11/12/2018.
//

import Foundation

public protocol M3U8Data {
    var stringValue: String? { get }
    init?(string: String)
}

extension String: M3U8Data {
    public var stringValue: String? {
        return self
    }

    public init?(string: String) {
        self = string
    }
}

extension Data: M3U8Data {
    public var stringValue: String? {
        return String(data: self, encoding: .utf8)
    }

    public init?(string: String) {
        guard let data = string.data(using: .utf8) else { return nil }
        self = data
    }
}

public struct M3U8Serializer {

    public enum Error: Swift.Error, LocalizedError {
        case missingData
        case missingM3UTag
        case missingURL
    }

    private let keySerializer = KeySerializer()
    private let mediaAlternativeRenditionSerializer = MediaAlternativeRenditionSerializer()
    private let mediaPlaylistSerializer = MediaPlaylistSerializer()
    private let iFramePlaylistSerializer = IFramePlaylistSerializer()

    public init() {}

    // MARK: - M3U8Serializer

    public func deserializeM3U8(from m3u8Data: M3U8Data) throws -> MasterPlaylist {
        guard let iterator = m3u8Data.lineIterator() else { throw Error.missingData }
        var currentStreamInfLine: String?
        var mediaAlternativeRenditions: [MediaAlternativeRendition] = []
        var iFramePlaylists: [IFramePlaylist] = []
        var mediaPlaylists: [MediaPlaylist] = []
        var extTagString: String?
        var version = 1
        var sessionKey: Key?
        iterator.forEach { line in
            if line.isEmpty {
            } else if line.isM3u8Tag {
                if line.hasM3u8Prefix(EXTPrefix.M3U) {
                    extTagString = line
                } else if line.hasM3u8Prefix(EXTPrefix.Version) {
                    if let versionInt = Int(
                        line.replacingOccurrences(of: EXTPrefix.Version + ":", with: "")
                        ) {
                        version = versionInt
                    }
                } else if line.hasM3u8Prefix(EXTPrefix.SessionKey) {
                    sessionKey = keySerializer.deserializeKey(from: line, in: .master)
                } else if line.hasM3u8Prefix(EXTPrefix.StreamInformation) {
                    currentStreamInfLine = line
                } else if line.hasM3u8Prefix(EXTPrefix.IFrameStreamInformation) {
                    if let iFramePlaylist = iFramePlaylistSerializer.deserializeIFramePlaylist(from: line) {
                        iFramePlaylists.append(iFramePlaylist)
                    }
                } else if line.hasM3u8Prefix(EXTPrefix.AlternativeRendition) {
                    if let alternativeRendition = mediaAlternativeRenditionSerializer
                        .deserializeMediaAlternativeRendition(from: line) {
                        mediaAlternativeRenditions.append(alternativeRendition)
                    }
                }
            } else if line.hasM3u8Prefix(EXTPrefix.Comment) {
            } else if let streamInfLine = currentStreamInfLine {
                let streamInfPath = line
                if
                    let mediaPlaylist = mediaPlaylistSerializer.deserializeMediaPlaylist(
                        fromStreamInfString: streamInfLine,
                        path: streamInfPath
                    ) {
                    mediaPlaylists.append(mediaPlaylist)
                }
                currentStreamInfLine = nil
            }
        }
        guard let extTag = extTagString else { throw Error.missingM3UTag }

        return MasterPlaylist(
            extTag: extTag,
            version: version,
            sessionKey: sessionKey,
            mediaAlternativeRenditions: mediaAlternativeRenditions,
            mediaPlaylists: mediaPlaylists,
            iFramePlaylists: iFramePlaylists
        )
    }

    func serialize<T: M3U8Data>(_ masterPlaylist: MasterPlaylist) -> T? {
        var string = masterPlaylist.extTag + "\n"
        string += EXTPrefix.Version + ":\(masterPlaylist.version)" + "\n"
        if let sessionKeyString: String = masterPlaylist.sessionKey.flatMap({ keySerializer.serialize($0) }) {
            string += sessionKeyString + "\n"
        }
        string = masterPlaylist
            .mediaAlternativeRenditions
            .map { mediaAlternativeRenditionSerializer.serialize($0) }
            .reduce(string) { $0 + ($0.isEmpty ? "" : "\n") + $1 }
        string += "\n"
        string = masterPlaylist
            .mediaPlaylists
            .map { mediaPlaylistSerializer.serialize($0) }
            .reduce(string) { $0 + ($0.isEmpty ? "" : "\n") + $1 }
        string += "\n"
        string = masterPlaylist
            .iFramePlaylists
            .map { iFramePlaylistSerializer.serialize($0) }
            .reduce(string) { $0 + ($0.isEmpty ? "" : "\n") + $1 }
        return T(string: string)
    }
}

private extension M3U8Data {
    func lineIterator() -> IndexingIterator<[String]>? {
        return stringValue?.components(separatedBy: CharacterSet.newlines).makeIterator()
    }
}
