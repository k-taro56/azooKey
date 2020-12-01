//
//  KeyModelProtocol.swift
//  Keyboard
//
//  Created by β α on 2020/04/12.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation
import SwiftUI

enum FlickKeyColorType{
    case normal
    case tabkey

    var color: Color {
        switch self {
        case .normal:
            return Store.shared.design.colors.normalKeyColor
        case .tabkey:
            return Store.shared.design.colors.specialKeyColor
        }
    }
}

protocol FlickKeyModelProtocol {
    var suggestModel: SuggestModel {get}
    var pressActions: [ActionType] {get}
    var longPressActions: [KeyLongPressActionType] {get}
    var flickKeys: [FlickDirection: FlickedKeyModel] {get}
    var keySize: CGSize {get}
    var needSuggestView: Bool {get}
    
    var variableSection: KeyModelVariableSection {get set}
    
    var label: KeyLabel {get}
    
    func isFlickAble(to direction: FlickDirection) -> Bool
    func press()
    func longPressReserve()
    func longPressEnd()
    func flick(to direction: FlickDirection)
    func suggestStateChanged(_ type: SuggestState)
    
    var backGroundColorWhenPressed: Color {get}
    var backGroundColorWhenUnpressed: Color {get}
    var suggestAnimation: Animation {get}

    func flickSensitivity(to direction: FlickDirection) -> CGFloat
    func sound()

}

extension ActionType{
    func sound(){
        switch self{
        case .input(_):
            SoundTools.click()
        case .delete(_):
            SoundTools.delete()
        case .smoothDelete:
            SoundTools.smoothDelete()
        case .moveTab(_), .enter, .changeCharacterType, .toggleShowMoveCursorView, .moveCursor(_):
            SoundTools.tabOrOtherKey()
        default:
            return
        }
    }
}

extension FlickKeyModelProtocol{
    func isFlickAble(to direction: FlickDirection) -> Bool {
        return flickKeys.keys.contains(direction)
    }
    
    func press(){
        self.pressActions.forEach{Store.shared.action.registerPressAction($0)}
    }
    
    func longPressReserve(){
        self.longPressActions.forEach{Store.shared.action.reserveLongPressAction($0)}
    }
    
    func longPressEnd(){
        self.longPressActions.forEach{Store.shared.action.registerLongPressActionEnd($0)}
    }
    
    func flick(to direction: FlickDirection){
        self.flickKeys[direction]?.flick()
    }
    
    func suggestStateChanged(_ type: SuggestState){
        self.suggestModel.setSuggestState(type)
    }
    
    var keySize: CGSize {
        return Store.shared.design.keyViewSize
    }
    
    var backGroundColorWhenPressed: Color {
        Store.shared.design.colors.highlightedKeyColor
    }
    var backGroundColorWhenUnpressed: Color {
        Store.shared.design.colors.normalKeyColor
    }
    var suggestAnimation: Animation {
        Animation.easeIn(duration: 0.1).delay(0.5)
    }

    func flickSensitivity(to direction: FlickDirection) -> CGFloat {
        return 25
    }

}
