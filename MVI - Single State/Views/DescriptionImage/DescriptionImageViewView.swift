//
//  DescriptionImageViewView.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI

struct DescriptionImageView: View {

    @StateObject private var intent: DescriptionImageViewIntent

    var body: some View {
        VStack {
            imageView()
            textView()
            Spacer()
        }
    }

    static func build(image: UIImage?) -> some View {
        guard let image = image else { return EmptyView().toAnyView() }

        let model = DescriptionImageViewModel(image: image)
        let intent = DescriptionImageViewIntent(model: model)
        let view = DescriptionImageView(intent: intent)

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
        DescriptionImageView.build(image: nil)
    }
}
#endif

