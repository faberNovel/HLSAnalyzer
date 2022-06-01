//
//  MediaAlternativeRenditionSerializer.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 14/12/2018.
//

import Foundation

enum XMediaKey: String, CaseIterable, M3U8Attribute {

    case type = "TYPE"
    case group = "GROUP-ID"
    case name = "NAME"
    case language = "LANGUAGE"
    case URI = "URI"
    case `default` = "DEFAULT"
    case autoselect = "AUTOSELECT"

    func serializedValue(in mediaAlternativeRendition: MediaAlternativeRendition) -> String? {
        let value: String?
        switch self {
        case .URI:
            value = mediaAlternativeRendition.URI
        case .type:
            value = mediaAlternativeRendition.type.rawValue
        case .group:
            value = mediaAlternativeRendition.group
        case .language:
            value = mediaAlternativeRendition.language
        case .name:
            value = mediaAlternativeRendition.name
        case .default:
            value = mediaAlternativeRendition.defaultRendition ? "YES" : nil
        case .autoselect:
            value = mediaAlternativeRendition.autoselect ? "YES" : nil
        }
        return value.flatMap { rawValue + "=" + $0 }
    }

    // MARK: - M3U8Attribute

    var valueType: ValueType {
        switch self {
        case .URI:
            return .string
        case .type:
            return .enumString
        case .group:
            return .string
        case .language:
            return .string
        case .name:
            return .string
        case .default:
            return .bool
        case .autoselect:
            return .bool
        }
    }
}

struct MediaAlternativeRenditionSerializer: M3U8AttributeListSerializer {

    // MARK: - M3U8AttributeListSerializer

    typealias AttributeList = XMediaKey
    typealias ModelType = MediaAlternativeRendition

    func attributeValueCreator(from model: MediaAlternativeRendition) -> (XMediaKey) -> String? {
        return { $0.serializedValue(in: model) }
    }

    func serialize(_ model: MediaAlternativeRendition) -> String {
        let optionString = attributeListString(from: model)
        return EXTPrefix.AlternativeRendition
            + ":"
            + optionString
    }

    // MARK: - MediaAlternativeRenditionSerializer

    func deserializeMediaAlternativeRendition(from XMediaString: String) -> MediaAlternativeRendition? {
        let XMediaKeyValues = keyValues(in: XMediaString)
        guard
            let type: String = XMediaKeyValues.typedValue(.type),
            let group: String = XMediaKeyValues.typedValue(.group),
            let language: String = XMediaKeyValues.typedValue(.language),
            let name: String = XMediaKeyValues.typedValue(.name),
            let autoselect: Bool = XMediaKeyValues.typedValue(.autoselect) else {
                return nil
        }
        return MediaAlternativeRendition(
            URI: XMediaKeyValues.typedValue(.URI),
            typeString: type,
            group: group,
            language: language,
            name: name,
            defaultRendition: XMediaKeyValues.typedValue(.default) ?? false,
            autoselect: autoselect
        )
    }
}
