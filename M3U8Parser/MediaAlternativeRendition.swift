//
//  MediaAlternativeRendition.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 14/12/2018.
//

import Foundation

public struct MediaAlternativeRendition {

    public enum MediaType: String {
        case audio = "AUDIO"
        case video = "VIDEO"
        case subtitles = "SUBTITLES"
    }

    public let type: MediaType
    public let group: String
    public let name: String
    public let language: String
    public let URI: String?
    public let defaultRendition: Bool
    public let autoselect: Bool

    public init?(URI: String?,
                 typeString: String,
                 group: String,
                 language: String,
                 name: String,
                 defaultRendition: Bool,
                 autoselect: Bool) {
        guard let type = MediaType(rawValue: typeString) else { return nil }
        self.init(
            URI: URI,
            type: type,
            group: group,
            language: language,
            name: name,
            defaultRendition: defaultRendition,
            autoselect: autoselect
        )
    }

    public init(URI: String?,
                type: MediaType,
                group: String,
                language: String,
                name: String,
                defaultRendition: Bool,
                autoselect: Bool) {
        self.URI = URI
        self.type = type
        self.group = group
        self.language = language
        self.name = name
        self.defaultRendition = defaultRendition
        self.autoselect = autoselect
    }
}
