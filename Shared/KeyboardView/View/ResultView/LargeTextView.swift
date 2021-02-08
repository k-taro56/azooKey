//
//  LargeTextView.swift
//  Keyboard
//
//  Created by β α on 2020/09/21.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation
import SwiftUI

struct LargeTextView: View {
    @ObservedObject private var variableStates = VariableStates.shared

    private var font: Font {
        Font.system(size: Design.shared.getMaximumTextSize(variableStates.magnifyingText), weight: .regular, design: .serif)
    }
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: true, content: {
                Text(variableStates.magnifyingText)
                    .font(font)
            })
            Button(action: {
                variableStates.isTextMagnifying = false
            }) {
                Image(systemName: "xmark")
                Text("閉じる")
                    .font(.body)
            }.frame(width: nil, height: Design.shared.keyViewSize.height)
        }
        .background(Color(UIColor.systemBackground))
        .frame(height: Design.shared.keyboardHeight + 2, alignment: .bottom)
    }
}