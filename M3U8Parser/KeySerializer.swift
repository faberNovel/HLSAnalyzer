//
//  KeySerializer.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 20/12/2018.
//

import Foundation

enum XKeyKey: String, CaseIterable, M3U8Attribute {

    case method = "METHOD"
    case URI = "URI"
    case IV = "IV"
    case keyFormat = "KEYFORMAT"
    case keyFormatVersion = "KEYFORMATVERSIONS"

    func serializedValue(in key: Key) -> String? {
        let value: String?
        switch self {
        case .method:
            value = key.method.rawValue
        case .URI:
            value = key.URI
        case .IV:
            value = key.IV
        case .keyFormat:
            value = key.keyFormat
        case .keyFormatVersion:
            value = key.keyFormatVersion
        }
        return value.flatMap { rawValue + "=" + $0 }
    }

    // MARK: - M3U8Attribute

    var valueType: ValueType {
        switch self {
        case .method:
            return .enumString
        case .IV, .keyFormat, .keyFormatVersion, .URI:
            return .string
        }
    }
}

struct KeySerializer: M3U8AttributeListSerializer {

    // MARK: - M3U8AttributeListSerializer

    typealias AttributeList = XKeyKey
    typealias ModelType = Key

    func attributeValueCreator(from model: Key) -> (XKeyKey) -> String? {
        return { $0.serializedValue(in: model) }
    }

    func serialize(_ model: Key) -> String {
        let optionString = attributeListString(from: model)
        return model.playlistType.prefix
            + ":"
            + optionString
    }

    // MARK: - KeySerializer

    func deserializeKey(from XKeyString: String,
                        in playlistType: Key.PlaylistType) -> Key? {
        let XKeyKeyValues = keyValues(in: XKeyString)
        guard
            let methodString: String = XKeyKeyValues.typedValue(.method) else {
                return nil
        }
        return Key(
            methodString: methodString,
            playlistType: playlistType,
            URI: XKeyKeyValues.typedValue(.URI),
            IV: XKeyKeyValues.typedValue(.IV),
            keyFormat: XKeyKeyValues.typedValue(.keyFormat),
            keyFormatVersion: XKeyKeyValues.typedValue(.keyFormatVersion)
        )
    }
}

private extension Key.PlaylistType {

    var prefix: String {
        switch self {
        case .master:
            return EXTPrefix.StreamInformation
        case .detail:
            return EXTPrefix.SegmentDuration
        }
    }
}
