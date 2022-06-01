//
//  M3U8Attribute.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 17/12/2018.
//

import Foundation

protocol M3U8Attribute {
    var rawValue: String { get }
    var valueType: ValueType { get }
}

enum ValueType {
    case digit
    case float
    case string
    case size
    case bool
    case enumString

    func typedValue<T>(from string: String) -> T? {
        let untypedValue: Any?
        switch self {
        case .string, .enumString:
            untypedValue = string
        case .digit:
            untypedValue = Int(string)
        case .float:
            untypedValue = Float(string)
        case .size:
            untypedValue = Resolution(string: string)
        case .bool:
            untypedValue = string == "YES"
        }
        return untypedValue as? T
    }

    // MARK: - Private

    fileprivate var pattern: String {
        switch self {
        case .digit:
            return "\\d+"
        case .float:
            return "\\d+(.\\d+)?"
        case .string:
            return "\"[^\"]*\""
        case .enumString:
            return "(\\w|-)+"
        case .size:
            return "\\d+x\\d+"
        case .bool:
            return "YES|NO"
        }
    }
}

private extension Resolution {

    init?(string: String) {
        let template = "(\\d+)x(\\d+)"
        guard
            let x = string
                .replace(template, withTemplate: "$1")
                .flatMap({ Int($0) }),
            let y = string
                .replace(template, withTemplate: "$2")
                .flatMap({ Int($0) }) else {
                    return nil
        }
        self.init(x: x, y: y)
    }
}

extension String {

    func value(for key: M3U8Attribute) -> String? {
        let pattern = "(.*)\(key.rawValue)=(\(key.valueType.pattern))(,(.*))*"
        do {
            let regex = try NSRegularExpression(
                pattern: pattern,
                options: [.caseInsensitive]
            )
            let numberOfMatches = regex.numberOfMatches(
                in: self,
                options: [.withTransparentBounds],
                range: NSRange(location: 0, length: self.count)
            )
            guard numberOfMatches > 0 else { return nil }
        } catch {}
        return replace(pattern, withTemplate: "$2")
    }

    func value(for extPrefixString: String, type: ValueType) -> String? {
        let pattern = "\(extPrefixString):(\(type.pattern))(,(.*))*"
        do {
            let regex = try NSRegularExpression(
                pattern: pattern,
                options: [.caseInsensitive]
            )
            let numberOfMatches = regex.numberOfMatches(
                in: self,
                options: [.withTransparentBounds],
                range: NSRange(location: 0, length: self.count)
            )
            guard numberOfMatches > 0 else { return nil }
        } catch {}
        return replace(pattern, withTemplate: "$1")
    }

    // MARK: - Private

    fileprivate func replace(_ pattern: String, withTemplate template: String) -> String? {
        do {
            let regex = try NSRegularExpression(
                pattern: pattern,
                options: [.caseInsensitive]
            )
            return regex.stringByReplacingMatches(
                in: self,
                options: [.withTransparentBounds],
                range: NSRange(location: 0, length: self.count),
                withTemplate: template
            )
        } catch {
            return nil
        }
    }
}

extension Dictionary where Value == String, Key: M3U8Attribute, Key: Hashable {

    func typedValue<T>(_ key: Key) -> T? {
        return self[key].flatMap { key.valueType.typedValue(from: $0) }
    }
}
