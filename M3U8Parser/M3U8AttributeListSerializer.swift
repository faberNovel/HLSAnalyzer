//
//  M3U8AttributeListSerializer.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 17/12/2018.
//

import Foundation

protocol M3U8AttributeListSerializer {
    associatedtype AttributeList: M3U8Attribute, Hashable, CaseIterable
    associatedtype ModelType
    func attributeValueCreator(from model: ModelType) -> (AttributeList) -> String?
    func serialize(_ model: ModelType) -> String
}

extension M3U8AttributeListSerializer {

    func keyValues(in string: String) -> [AttributeList: String] {
        return AttributeList
            .allCases
            .reduce([AttributeList: String]()) {
                var nextDictionary = $0
                nextDictionary[$1] = string.value(for: $1)
                return nextDictionary
            }
    }

    func attributeListString(from model: ModelType) -> String {
        return AttributeList
            .allCases
            .compactMap(attributeValueCreator(from: model))
            .reduce("") { $0 + ($0.isEmpty ? "" : ",") + $1 }
    }
}
