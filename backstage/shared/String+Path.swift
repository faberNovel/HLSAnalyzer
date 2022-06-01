//
//  String+Path.swift
//  backstage
//
//  Created by Benjamin Lavialle on 01/06/2022.
//

import Foundation

public extension String {

    var readablePathName: String {
        URL(string: self)?.lastPathComponent ?? self
    }
}
