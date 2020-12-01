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
    let text: String
    init(_ text: String){
        self.text = text
    }
    
    var font: Font {
        return Font.system(size: Store.shared.design.getMaximumTextSize(self.text), weight: .regular, design: .serif)
    }
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: true, content: {
                Text(self.text)
                    .font(font)
            })
            Button(action: {
                Store.shared.keyboardModelVariableSection.isTextMagnifying = false
            }) {
                Image(systemName: "xmark")
                Text("閉じる")
                    .font(.body)
            }.frame(width: nil, height: Store.shared.design.keyViewSize.height)
        }
        .background(Color(UIColor.systemBackground))
        .frame(height: Store.shared.design.keyboardHeight)
    }
}