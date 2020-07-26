//
//  DescriptionImageViewIdent.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI
import Combine

class DescriptionImageViewIntent: ObservableObject {

    let model: DescriptionImageViewModeling

    private var sceneNameModel: DescriptionImageViewModel! { model as? DescriptionImageViewModel }
    private var cancellable: Set<AnyCancellable> = []

    init(image: UIImage) {
        self.model = DescriptionImageViewModel(image: image)
        cancellable.insert(sceneNameModel.objectWillChange.sink { self.objectWillChange.send() })
    }
}
