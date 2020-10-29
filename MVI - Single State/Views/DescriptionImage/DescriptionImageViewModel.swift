//
//  DescriptionImageViewModel.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI
import Combine

protocol DescriptionImageStateViewModel {
    var image: UIImage { get }
    var text: String { get }
}

protocol DescriptionImageDisplayViewModel {
}

// MARK: - DescriptionImageViewModel & DescriptionImageStateViewModel
class DescriptionImageViewModel: ObservableObject, DescriptionImageStateViewModel {

    @Published private(set) var image: UIImage
    @Published private(set) var text: String = "An apple is an edible fruit produced by an apple tree (Malus domestica). Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus. The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today. Apples have been grown for thousands of years in Asia and Europe and were brought to North America by European colonists. Apples have religious and mythological significance in many cultures, including Norse, Greek and European Christian tradition."

    init(image: UIImage) {
        self.image = image
    }
}

// MARK: - DescriptionImageDisplayViewModel
extension DescriptionImageViewModel: DescriptionImageDisplayViewModel {

}
