//
//  KeyValueView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 30/06/2022.
//

import Foundation
import SwiftUI

struct KeyValueView: View {

    let key: String
    let value: String?

    var body: some View {
        HStack {
            Text(LocalizedStringKey(key)).font(.body.bold())
            if let value = value {
                Spacer()
                Text(value).truncationMode(.head).lineLimit(1).foregroundColor(.gray)
            }
        }
    }
}
