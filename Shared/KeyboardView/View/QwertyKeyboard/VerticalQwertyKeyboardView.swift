//
//  VerticalQwertyKeyboardView.swift
//  Keyboard
//
//  Created by β α on 2020/09/18.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation
import SwiftUI

struct QwertyKeyboardView: View{
    @ObservedObject private var variableStates = VariableStates.shared
    private let theme: ThemeData
    private let tabDesign: TabDependentDesign
    private let keyModels: [[QwertyKeyModelProtocol]]

    init(keyModels: [[QwertyKeyModelProtocol]], theme: ThemeData){
        self.keyModels = keyModels
        self.theme = theme
        self.tabDesign = TabDependentDesign(width: 10, height: 4, layout: .qwerty, orientation: VariableStates.shared.keyboardOrientation)
    }

    private var verticalIndices: Range<Int> {
        keyModels.indices
    }

    private func horizontalIndices(v: Int) -> Range<Int> {
        keyModels[v].indices
    }

    var body: some View {
        VStack(spacing: tabDesign.verticalSpacing){
            ForEach(self.verticalIndices, id: \.self){(v: Int) in
                HStack(spacing: tabDesign.horizontalSpacing){
                    ForEach(self.horizontalIndices(v: v), id: \.self){(h: Int) in
                        QwertyKeyView(model: self.keyModels[v][h], theme: theme, tabDesign: tabDesign)
                    }
                }
            }
        }
    }
}
