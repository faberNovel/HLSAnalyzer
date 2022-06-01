//
//  Resolution.swift
//  ADDynamicLogLevel
//
//  Created by Benjamin Lavialle on 17/12/2018.
//

import Foundation

public struct Resolution {
    public let x: Int
    public let y: Int

    public var stringValue: String {
        return "\(x)x\(y)"
    }
}
