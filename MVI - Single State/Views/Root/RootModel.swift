//
//  RootModel.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI
import Combine

protocol RootStateModel {
    var image: UIImage? { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    var routerSubject: PassthroughSubject<RootRouter.ScreenType, Never> { get }
}

protocol RootDisplayModel {
    func dispalyLoading()
    func display(image: UIImage)
    func dispaly(loadingFailError: Error)
    func routeTodDescriptionImage()
}

// MARK: - RootModel
class RootModel: ObservableObject, RootStateModel {

    enum StateType {
        case loading, show(image: UIImage), failLoad(error: Error)
    }

    @Published private(set) var image: UIImage?
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var error: Error?

    let routerSubject = PassthroughSubject<RootRouter.ScreenType, Never>()
}

// MARK: - RootDisplayModel
extension RootModel: RootDisplayModel {

    func dispalyLoading() {
        isLoading = true
        error = nil
        image = nil
    }

    func display(image: UIImage) {
        self.image = image
        isLoading = false
    }

    func dispaly(loadingFailError: Error) {
        self.error = loadingFailError
        isLoading = false
        routerSubject.send(.alert(title: "Error", message: "It was not possible to upload a image"))
    }

    func routeTodDescriptionImage() {
        guard let image = self.image else {
            routerSubject.send(.alert(title: "Error", message: "Failed to open the screen"))
            return
        }
        routerSubject.send(.descriptionImage(image: image))
    }
}
