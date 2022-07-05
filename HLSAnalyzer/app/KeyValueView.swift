//
//  KeyValueView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 30/06/2022.
//

import Foundation
import SwiftUI

struct KeyValueView: View {

    @State private var showingPopover = false
    let key: String
    let link: URL?
    let value: String?

    init(key: String, link: URL? = nil, value: String?) {
        self.key = key
        self.link = link
        self.value = value
    }

    var body: some View {
        HStack {
            if let link = link {
                Link(LocalizedStringKey(key), destination: link)
                    .font(.body.bold())
            } else {
                Text(LocalizedStringKey(key))
                    .font(.body.bold())
            }
            if let value = value {
                Spacer()
                Text(value).truncationMode(.head).lineLimit(1).foregroundColor(.gray)
            }
        }
    }
}
