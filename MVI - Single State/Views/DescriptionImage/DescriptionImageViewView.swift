//
//  DescriptionImageViewView.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI

struct DescriptionImageView: View {

    enum ViewActionType {
        case didTapImage
    }
    var action: (ViewActionType) -> Void

    @ObservedObject private var intent: DescriptionImageViewIntent

    var body: some View {
        VStack {
            imageView().onTapGesture(perform: {
                self.action(.didTapImage)
            })
            textView()
            Spacer()
        }
    }

    static func build(image: UIImage?, action: @escaping (ViewActionType) -> Void) -> some View {
        guard let image = image else { return EmptyView().toAnyView() }
        let intent = DescriptionImageViewIntent(image: image)
        let view = DescriptionImageView(action: action, intent: intent)
        return view.toAnyView()
    }
}

// MARK: - Private - Views
private extension DescriptionImageView {

    private func imageView() -> some View {
        Image(uiImage: intent.model.image)
            .resizable()
            .scaledToFit()
    }

    private func textView() -> some View {
        Text(intent.model.text)
            .padding()
    }
}

#if DEBUG
// MARK: - Previews
struct DescriptionImageView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionImageView.build(image: nil, action: { _ in

        })
    }
}
#endif

