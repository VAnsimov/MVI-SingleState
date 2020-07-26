//
//  View+Ex.swift
//  MVI - Single State
//
//  Created by Vyacheslav Ansimov on 26.07.2020.
//  Copyright © 2020 Vyacheslav Ansimov. All rights reserved.
//

import SwiftUI

extension View {

    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
