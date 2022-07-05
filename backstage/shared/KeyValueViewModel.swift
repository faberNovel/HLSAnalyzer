//
//  KeyValueViewModel.swift
//  backstage
//
//  Created by Benjamin Lavialle on 01/06/2022.
//

import Foundation

public protocol KeyValueNavigation {
    var rows: [NavigableKeyValueViewModel<Self>]? { get }
}

public struct KeyValueViewModel: Identifiable {
    public let id = UUID()
    public let key: String
    public let link: URL?
    public let value: String?

    public init(key: String, link: URL? = nil, value: String?) {
        self.key = key
        self.link = link
        self.value = value
    }
}

public struct NavigableKeyValueViewModel<Navigation: KeyValueNavigation>: Identifiable {
    public let viewModel: KeyValueViewModel
    public let navigation: Navigation?

    public var id: UUID { viewModel.id }

    public var rows: [Self]? { navigation?.rows }

    public init(key: String, link: URL? = nil, value: String?, navigation: Navigation? = nil) {
        self.viewModel = KeyValueViewModel(key: key, link: link, value: value)
        self.navigation = navigation
    }
}

public struct LeafNavigation: KeyValueNavigation {
    public let rows: [NavigableKeyValueViewModel<LeafNavigation>]? = nil
}

public typealias LeafKeyValueViewModel = NavigableKeyValueViewModel<LeafNavigation>

extension LeafKeyValueViewModel {

    func contravariant<NewNavigation: KeyValueNavigation>() -> NavigableKeyValueViewModel<NewNavigation> {
        NavigableKeyValueViewModel<NewNavigation>(key: viewModel.key, link: viewModel.link, value: viewModel.value)
    }

}
