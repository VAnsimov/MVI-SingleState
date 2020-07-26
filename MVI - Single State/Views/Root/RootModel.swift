//
//  RootModel.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI
import Combine

protocol RootModeling {
    var image: UIImage? { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    var routerSubject: PassthroughSubject<RootRouter.ScreenType, Never> { get }
}

class RootModel: ObservableObject, RootModeling {

    enum StateType {
        case loading, show(image: UIImage), failLoad(error: Error)
    }

    @Published private(set) var image: UIImage?
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var error: Error?

    let routerSubject = PassthroughSubject<RootRouter.ScreenType, Never>()

    func update(state: StateType) {
        switch state {
        case .loading:
            isLoading = true
            error = nil
            image = nil

        case .show(let image):
            self.image = image
            isLoading = false

        case .failLoad(let error):
            self.error = error
            isLoading = false
        }
    }
}
