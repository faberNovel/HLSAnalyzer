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
        VStack {
            KeyValueView(key: "duration", value: "\(segment.duration)")
            KeyValueView(key: "sequence", value: segment.sequence.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "subrangeLength", value: segment.subrangeLength.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "subrangeStart", value: segment.subrangeStart.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "title", value: segment.title.flatMap { "\($0)" } ?? "_")
            KeyValueView(key: "discontinuity", value: "\(segment.discontinuity)")
            KeyValueView(key: "path", value: "\(segment.path)")
            Spacer()
        }
    }
}
