//
//  Key.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 20/12/2018.
//

import Foundation

public struct Key {

    public enum Method: String {
        case none = "NONE"
        case AES128 = "AES-128"
        case sampleAES = "SAMPLE-AES"
    }

    public enum PlaylistType {
        case master
        case detail
    }

    public let method: Method
    public let playlistType: PlaylistType
    public let URI: String?
    public let IV: String?
    public let keyFormat: String?
    public let keyFormatVersion: String?

    public init?(methodString: String,
                 playlistType: PlaylistType,
                 URI: String?,
                 IV: String?,
                 keyFormat: String?,
                 keyFormatVersion: String?) {
        guard let method = Method(rawValue: methodString) else { return nil }
        self.init(
            method: method,
            playlistType: playlistType,
            URI: URI,
            IV: IV,
            keyFormat: keyFormat,
            keyFormatVersion: keyFormatVersion
        )
    }

    public init(method: Method,
                playlistType: PlaylistType,
                URI: String?,
                IV: String?,
                keyFormat: String?,
                keyFormatVersion: String?) {
        self.method = method
        self.playlistType = playlistType
        self.URI = URI
        self.IV = IV
        self.keyFormat = keyFormat
        self.keyFormatVersion = keyFormatVersion
    }
}
