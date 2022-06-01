//
//  MediaSegment.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 11/12/2018.
//

import Foundation

public struct MediaSegment {
    public let duration: Float
    public let sequence: Int?
    public let subrangeLength: Int?
    public let subrangeStart: Int?
    public let title: String?
    public let discontinuity: Bool
    public let path: String
}
