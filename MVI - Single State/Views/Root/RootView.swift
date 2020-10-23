//
//  RootView.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI

struct RootView: View {

    @StateObject private var intent: RootIntent

    var body: some View {
        NavigationView {
            ZStack {
                imageView()
                    .cornerRadius(6)
                    .shadow(radius: 2)
                    .frame(width: 100, height: 100)
                    .onTapGesture(perform: intent.onTapImage)
                errorView()
                loadView()
            }
            .overlay(RootRouter(screen: intent.model.routerSubject))
            .onAppear(perform: intent.onAppear)
        }
    }

    static func build() -> some View {
        let model = RootModel()
        let intent = RootIntent(model: model)
        let view = RootView(intent: intent)

        return view
    }
}

// MARK: - Private - Views
private extension RootView {

    private func imageView() -> some View {
        guard let image = intent.model.image else { return Color.gray.toAnyView() }

        return Image(uiImage: image)
            .resizable()
            .toAnyView()
    }

    private func loadView() -> some View {
        guard intent.model.isLoading else { return EmptyView().toAnyView() }

        return ZStack {
            Color.white
            Text("Loading")
        }.toAnyView()
    }

    private func errorView() -> some View {
        guard intent.model.error != nil else { return EmptyView().toAnyView() }

        return ZStack {
            Color.white
            Text("Fail")
        }.toAnyView()
    }
}

#if DEBUG
// MARK: - Previews
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView.build()
    }
}
#endif

