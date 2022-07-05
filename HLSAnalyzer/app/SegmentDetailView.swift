//
//  SegmentDetailView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 31/05/2022.
//

import Foundation
import SwiftUI
import M3U8Parser

struct SegmentDetailView: View {

    let segment: MediaSegment

    var body: some View {
        VStack(spacing: 8) {
            KeyValueView(key: "segment_duration", link: segment.rfcLink, value: "\(segment.duration)")
            KeyValueView(key: "segment_sequence", value: segment.sequence.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "segment_subrangeLength", link: segment.byterangeRfcLink, value: segment.subrangeLength.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "segment_subrangeStart", link: segment.byterangeRfcLink, value: segment.subrangeStart.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "segment_title", link: segment.rfcLink, value: segment.title.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "segment_discontinuity", link: segment.discontinuityRfcLink, value: "\(segment.discontinuity)")
            KeyValueView(key: "segment_path", link: segment.rfcLink, value: "\(segment.path)")
            Spacer()
        }
        .padding(20)
    }
}
