//
//  M3U8+RFCLinks.swift
//  backstage
//
//  Created by Benjamin Lavialle on 30/06/2022.
//

import Foundation
import M3U8Parser

public extension MasterPlaylist {
    var tagRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.1.1") }
    var versionRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.1.2") }
    var alternativeRenditionRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.1") }
    var mediaPlaylistsRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.1") }
    var iFramePlaylistsRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.3") }
    var sessionKeyRfclink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4") }
    var sessionKeyMethodRfclink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4") }
    var sessionKeyURIRfclink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4") }
    var sessionKeyIVRfclink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4") }
    var sessionKeyKeyFormatRfclink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4") }
    var sessionKeyKeyFormatVersionRfclink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.4") }
}

public extension IFramePlaylist {
    var rfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.3") }
}

public extension MediaAlternativeRendition {
    var rfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.1") }
}

public extension MediaPlaylist {
    var resolutionRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.2") }
    var bandwidthRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.2") }
    var audioRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.2") }
    var codecsRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.2") }
    var pathRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.4.2") }
}

public extension MediaPlaylistDetail {
    var tagRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.1.1") }
    var versionRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.1.2") }
    var targetDurationRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.3.1") }
    var mediaSequenceRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.3.2") }
    var segmentsRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-3") }
}

public extension MediaSegment {
    var rfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2") }
    var sequenceRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.1") }
    var byterangeRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.2") }
    var discontinuityRfcLink: URL? { URL(string: "https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.3") }

}

