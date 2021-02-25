//
//  KeyboardView.swift
//  Calculator-Keyboard
//
//  Created by β α on 2020/04/08.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation
import SwiftUI


struct ThemeEnvironmentKey: EnvironmentKey {
    typealias Value = ThemeData

    static var defaultValue: ThemeData = .default
}

extension EnvironmentValues {
    var themeEnvironment: ThemeData {
        get {
            return self[ThemeEnvironmentKey.self]
        }
        set {
            self[ThemeEnvironmentKey.self] = newValue
        }
    }
}


struct KeyboardView<Candidate: ResultViewItemData>: View {
    @ObservedObject private var variableStates = VariableStates.shared
    private let resultModel: ResultModel<Candidate>

    @State private var messageManager: MessageManager = MessageManager()
    @State private var isResultViewExpanded = false

    @Environment(\.themeEnvironment) private var theme

    private var sharedResultData = SharedResultData<Candidate>()
    private let defaultTab: Tab.ExistentialTab?

    init(resultModel: ResultModel<Candidate>, defaultTab: Tab.ExistentialTab? = nil){
        self.resultModel = resultModel
        self.defaultTab = defaultTab
    }

    var body: some View {
        ZStack{
            theme.backgroundColor.color
                .frame(maxWidth: .infinity)
                .overlay(
                    Group{
                        if let image = theme.picture.image{
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: Design.shared.screenWidth, height: Design.shared.keyboardScreenHeight)
                                .clipped()
                        }
                    }
                )
            if isResultViewExpanded{
                ExpandedResultView(isResultViewExpanded: $isResultViewExpanded, sharedResultData: sharedResultData)
                    .padding(.bottom, 2)
            }else{
                VStack(spacing: 0){
                    ResultView(model: resultModel, isResultViewExpanded: $isResultViewExpanded, sharedResultData: sharedResultData)
                        .padding(.vertical, 6)
                    if variableStates.refreshing{
                        keyboardView(tab: variableStates.tabManager.currentTab.existential)
                    }else{
                        keyboardView(tab: variableStates.tabManager.currentTab.existential)
                    }
                }.padding(.bottom, 2)
            }
            if variableStates.isTextMagnifying{
                LargeTextView()
            }
            
            ForEach(messageManager.necessaryMessages, id: \.id){data in
                if messageManager.requireShow(data.id){
                    MessageView(data: data, manager: $messageManager)
                }
            }
        }
    }

    func keyboardView(tab: Tab.ExistentialTab) -> some View {
        let target: Tab.ExistentialTab
        if let defaultTab = defaultTab{
            target = defaultTab
        }else{
            target = tab
        }

        return Group{
            switch target{
            case .flick_hira:
                switch variableStates.keyboardOrientation{
                case .vertical:
                    VerticalFlickKeyboardView(keyModels: VerticalFlickDataProvider().hiraKeyboard)
                case .horizontal:
                    HorizontalFlickKeyboardView(keyModels: HorizontalFlickDataProvider().hiraKeyboard)
                }
            case .flick_abc:
                switch variableStates.keyboardOrientation{
                case .vertical:
                    VerticalFlickKeyboardView(keyModels: VerticalFlickDataProvider().abcKeyboard)
                case .horizontal:
                    HorizontalFlickKeyboardView(keyModels: HorizontalFlickDataProvider().abcKeyboard)
                }
            case .flick_numbersymbols:
                switch variableStates.keyboardOrientation{
                case .vertical:
                    VerticalFlickKeyboardView(keyModels: VerticalFlickDataProvider().numberKeyboard)
                case .horizontal:
                    HorizontalFlickKeyboardView(keyModels: HorizontalFlickDataProvider().numberKeyboard)
                }
            case .qwerty_hira:
                QwertyKeyboardView(keyModels: QwertyDataProvider().hiraKeyboard)
            case .qwerty_abc:
                QwertyKeyboardView(keyModels: QwertyDataProvider().abcKeyboard)
            case .qwerty_number:
                QwertyKeyboardView(keyModels: QwertyDataProvider().numberKeyboard)
            case .qwerty_symbols:
                QwertyKeyboardView(keyModels: QwertyDataProvider().symbolsKeyboard)
            case let .custard(custard):
                CustomKeyboardView(custard: custard)
            }
        }
    }
}
