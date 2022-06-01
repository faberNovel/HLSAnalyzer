//
//  MediaSegmentSerializer.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 03/07/2019.
//

import Foundation

enum SegmentKey: String, CaseIterable, M3U8Attribute {

    case discontinuity = "DISCONTINUITY"

    func serializedValue(in segment: MediaSegment) -> String? {
        let value: String?
        switch self {
        case .discontinuity:
            value = segment.discontinuity ? "YES" : nil
        }
        return value.flatMap { rawValue + "=" + $0 }
    }

    // MARK: - M3U8Attribute

    var valueType: ValueType {
        switch self {
        case .discontinuity:
            return .bool
        }
    }
}

struct MediaSegmentSerializer: M3U8AttributeListSerializer {

    // MARK: - M3U8AttributeListSerializer

    typealias AttributeList = SegmentKey
    typealias ModelType = MediaSegment

    func attributeValueCreator(from model: MediaSegment) -> (SegmentKey) -> String? {
        return { $0.serializedValue(in: model) }
    }


    func serialize(_ model: MediaSegment) -> String {
        let optionString = attributeListString(from: model)
        return EXTPrefix.SegmentDuration
            + ":"
            + "\(model.duration)"
            + optionString
            + "\n"
            + model.path
    }

    // MARK: - MediaPlaylistSerializer

    func deserializeMediaSegment(fromExtInfString extInfString: String,
                                 path: String) -> MediaSegment? {
        guard
            let durationString = extInfString.value(
                for: EXTPrefix.SegmentDuration,
                type: ValueType.float
            ),
            let duration = Float(durationString) else {
                return nil
        }
        return MediaSegment(
            duration: duration,
            sequence: nil,
            subrangeLength: nil,
            subrangeStart: nil,
            title: nil,
            discontinuity: false,
            path: path
        )
    }
}
