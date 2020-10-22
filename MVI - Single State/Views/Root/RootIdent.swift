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

    let model: RootStateModel

    private var displayModel: RootDisplayModel
    private var cancellable: Set<AnyCancellable> = []

    init(model: RootModel) {
        self.model = model
        self.displayModel = model
        cancellable.insert(model.objectWillChange.sink { self.objectWillChange.send() })
    }
}

// MARK: - API
extension RootIntent {

    func onAppear() {
        displayModel.dispalyLoading()

        let url: URL! = URL(string: "https://upload.wikimedia.org/wikipedia/commons/f/f4/Honeycrisp.jpg")
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.displayModel.dispaly(loadingFailError: error ?? NSError())
                }
                return
            }
            DispatchQueue.main.async {
                self?.displayModel.display(image: image)
            }
        }
        task.resume()
    }

    func onTapImage() {
        displayModel.routeTodDescriptionImage()
    }
}
