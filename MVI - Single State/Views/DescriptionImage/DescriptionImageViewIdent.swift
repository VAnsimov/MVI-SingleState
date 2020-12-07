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

    let model: DescriptionImageStateViewModel

    private var displayModel: DescriptionImageDisplayViewModel
    private var cancellable: Set<AnyCancellable> = []

    init(model: DescriptionImageViewModel) {
        self.model = model
        self.displayModel = model
        cancellable.insert(model.objectWillChange.sink { [weak self] in
            DispatchQueue.main.async { self?.objectWillChange.send() }
        })
    }
}
