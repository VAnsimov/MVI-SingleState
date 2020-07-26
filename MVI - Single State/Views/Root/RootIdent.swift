//
//  RootIdent.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI
import Combine

class RootIntent: ObservableObject {

    let model: RootModeling

    private var rootModel: RootModel! { model as? RootModel }
    private var cancellable: Set<AnyCancellable> = []

    init() {
        self.model = RootModel()
        cancellable.insert(rootModel.objectWillChange.sink { self.objectWillChange.send() })
    }
}

// MARK: - API
extension RootIntent {

    func onAppear() {
        rootModel?.update(state: .loading)

        let url: URL! = URL(string: "https://upload.wikimedia.org/wikipedia/commons/f/f4/Honeycrisp.jpg")
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.rootModel?.update(state: .failLoad(error: error ?? NSError()))
                    self?.rootModel?.routerSubject.send(.alert(title: "Error",
                                                               message: "It was not possible to upload a image"))
                }
                return
            }
            DispatchQueue.main.async {
                self?.rootModel?.update(state: .show(image: image))
            }
        }

        task.resume()
    }

    func onTapImage() {
        // 1
        guard let image = rootModel?.image else {
            rootModel?.routerSubject.send(.alert(title: "Error", message: "Failed to open the screen"))
            return
        }
        // 2
        model.routerSubject.send(.descriptionImage(image: image))
    }
}
