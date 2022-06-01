//
//  MediaPlaylistSerializer.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 11/12/2018.
//

import Foundation

enum StreamInfKey: String, CaseIterable, M3U8Attribute {
    case bandwidth = "BANDWIDTH"
    case codecs = "CODECS"
    case resolution = "RESOLUTION"
    case audio = "AUDIO"

    func serializedValue(in mediaPlaylist: MediaPlaylist) -> String? {
        let value: String?
        switch self {
        case .bandwidth:
            value = String(mediaPlaylist.bandwidth)
        case .resolution:
            value = mediaPlaylist.resolution?.stringValue
        case .codecs:
            value = mediaPlaylist.codecs
        case .audio:
            value = mediaPlaylist.audio
        }
        return value.flatMap { rawValue + "=" + $0 }
    }

    // MARK: - M3U8Attribute

    var valueType: ValueType {
        switch self {
        case .bandwidth:
            return .digit
        case .codecs:
            return .string
        case .resolution:
            return .size
        case .audio:
            return .string
        }
    }
}

struct MediaPlaylistSerializer: M3U8AttributeListSerializer {

    // MARK: - M3U8AttributeListSerializer

    typealias AttributeList = StreamInfKey
    typealias ModelType = MediaPlaylist

    func attributeValueCreator(from model: MediaPlaylist) -> (AttributeList) -> String? {
        return { $0.serializedValue(in: model) }
    }

    func serialize(_ model: MediaPlaylist) -> String {
        let optionString = attributeListString(from: model)
        return EXTPrefix.StreamInformation
            + ":"
            + optionString
            + "\n"
            + model.path
    }

    // MARK: - MediaPlaylistSerializer

    func deserializeMediaPlaylist(fromStreamInfString streamInfString: String,
                                  path: String) -> MediaPlaylist? {
        let streamInfKeyValues = keyValues(in: streamInfString)
        guard let bandwidth: Int = streamInfKeyValues.typedValue(.bandwidth) else { return nil }
        return MediaPlaylist(
            resolution: streamInfKeyValues.typedValue(.resolution),
            bandwidth: bandwidth,
            audio: streamInfKeyValues.typedValue(.audio),
            codecs: streamInfKeyValues.typedValue(.codecs),
            path: path
        )
    }
}
