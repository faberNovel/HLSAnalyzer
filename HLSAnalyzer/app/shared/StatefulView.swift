//
//  StatefulView.swift
//  HLSAnalyzer
//
//  Created by Benjamin Lavialle on 02/06/2022.
//

import Foundation
import SwiftUI

struct StatefulView<ViewModel, ViewModelView: View, PlaceholderView: View>: View {

    @Binding var error: Error?
    @Binding var loading: Bool
    @Binding var viewModel: ViewModel?
    let placeholderView: PlaceholderView
    let viewModelView: (ViewModel) -> ViewModelView

    init(error: Binding<Error?> = Binding(get: { nil }, set: { _ in }),
         loading: Binding<Bool> = Binding(get: { false }, set: { _ in }),
         viewModel: Binding<ViewModel?>,
         @ViewBuilder placeholderView: @escaping () -> PlaceholderView,
         @ViewBuilder viewModelView: @escaping (ViewModel) -> ViewModelView) {
        self._error = error
        self._loading = loading
        self._viewModel = viewModel
        self.placeholderView = placeholderView()
        self.viewModelView = viewModelView
    }

    var body: some View {
        let binding = Binding<Bool> {
            error != nil
        } set: { _ in
            error = nil
        }
        Group {
            if let viewModel = viewModel {
                viewModelView(viewModel)
            } else {
                placeholderView
            }
        }
        .alert(error?.localizedDescription ?? "error", isPresented: binding) {}
    }
}

extension StatefulView where PlaceholderView == EmptyView {

    init(error: Binding<Error?> = Binding(get: { nil }, set: { _ in }),
         loading: Binding<Bool> = Binding(get: { false }, set: { _ in }),
         viewModel: Binding<ViewModel?>,
         @ViewBuilder viewModelView: @escaping (ViewModel) -> ViewModelView) {
        self.init(
            error: error,
            loading: loading,
            viewModel: viewModel,
            placeholderView: { EmptyView() },
            viewModelView: viewModelView
        )
    }
}
