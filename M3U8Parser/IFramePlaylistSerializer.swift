//
//  IFramePlaylistSerializer.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 21/12/2018.
//

import Foundation

enum IFrameKey: String, CaseIterable, M3U8Attribute {

    case bandwidth = "BANDWIDTH"
    case codecs = "CODECS"
    case resolution = "RESOLUTION"
    case URI = "URI"

    func serializedValue(in IFramePlaylist: IFramePlaylist) -> String? {
        let value: String?
        switch self {
        case .URI:
            value = IFramePlaylist.URI
        case .bandwidth:
            value = String(IFramePlaylist.bandwidth)
        case .resolution:
            value = IFramePlaylist.resolution?.stringValue
        case .codecs:
            value = IFramePlaylist.codecs
        }
        return value.flatMap { rawValue + "=" + $0 }
    }

    // MARK: - M3U8Attribute

    var valueType: ValueType {
        switch self {
        case .bandwidth:
            return .digit
        case .codecs, .URI:
            return .string
        case .resolution:
            return .size
        }
    }
}

struct IFramePlaylistSerializer: M3U8AttributeListSerializer {

    // MARK: - M3U8AttributeListSerializer

    typealias AttributeList = IFrameKey
    typealias ModelType = IFramePlaylist

    func attributeValueCreator(from model: IFramePlaylist) -> (IFrameKey) -> String? {
        return { $0.serializedValue(in: model) }
    }

    func serialize(_ model: IFramePlaylist) -> String {
        let optionString = attributeListString(from: model)
        return EXTPrefix.IFrameStreamInformation
            + ":"
            + optionString
    }

    // MARK: - IFramePlaylistSerializer

    func deserializeIFramePlaylist(from IFrameStreamInfString: String) -> IFramePlaylist? {
        let IFrameStreamInfKeyValues = keyValues(in: IFrameStreamInfString)
        guard let bandwidth: Int = IFrameStreamInfKeyValues.typedValue(.bandwidth),
            let URI: String = IFrameStreamInfKeyValues.typedValue(.URI) else {
            return nil
        }
        return IFramePlaylist(
            bandwidth: bandwidth,
            URI: URI,
            resolution: IFrameStreamInfKeyValues.typedValue(.resolution),
            codecs: IFrameStreamInfKeyValues.typedValue(.codecs)
        )
    }
}
