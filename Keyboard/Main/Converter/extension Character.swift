//
//  extension Character.swift
//  Keyboard
//
//  Created by β α on 2020/09/03.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation

extension Character{
    private static let kogakiKana: Set<Character> = [
        "ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "ゕ", "ゖ", "っ", "ゃ", "ゅ", "ょ", "ゎ",
        "ァ", "ィ", "ゥ", "ェ", "ォ", "ヵ", "ヶ", "ッ", "ャ", "ュ", "ョ", "ヮ"
    ]
    
    private static let dakutenKana: Set<Character> = [
        "ゔ", "が", "ぎ", "ぐ", "げ", "ご", "ざ", "じ", "ず", "ぜ", "ぞ", "だ", "ぢ", "づ", "で", "ど", "ば", "び", "ぶ", "べ", "ぼ",
        "ヴ", "ガ", "ギ", "グ", "ゲ", "ゴ", "ザ", "ジ", "ズ", "ゼ", "ゾ", "ダ", "ヂ", "ヅ", "デ", "ド", "バ", "ビ", "ブ", "ベ", "ボ"
    ]
    
    var isKogana: Bool {
        return Character.kogakiKana.contains(self)
    }
    
    var kogaki: Character {
        switch self{
        case "あ":return "ぁ"
        case "い":return "ぃ"
        case "う":return "ぅ"
        case "え":return "ぇ"
        case "お":return "ぉ"
        case "か":return "ゕ"
        case "け":return "ゖ"
        case "つ":return "っ"
        case "や":return "ゃ"
        case "ゆ":return "ゅ"
        case "よ":return "ょ"
        case "わ":return "ゎ"
        case "ア":return "ァ"
        case "イ":return "ィ"
        case "ウ":return "ゥ"
        case "エ":return "ェ"
        case "オ":return "ォ"
        case "カ":return "ヵ"
        case "ケ":return "ヶ"
        case "ツ":return "ッ"
        case "ヤ":return "ャ"
        case "ユ":return "ュ"
        case "ヨ":return "ョ"
        case "ワ":return "ヮ"
        default: return self
        }
    }
    
    var ogaki: Character {
        switch self{
        case "ぁ":return "あ"
        case "ぃ":return "い"
        case "ぅ":return "う"
        case "ぇ":return "え"
        case "ぉ":return "お"
        case "ゕ":return "か"
        case "ゖ":return "け"
        case "っ":return "つ"
        case "ゃ":return "や"
        case "ゅ":return "ゆ"
        case "ょ":return "よ"
        case "ゎ":return "わ"
        case "ァ":return "ア"
        case "ィ":return "イ"
        case "ゥ":return "ウ"
        case "ェ":return "エ"
        case "ォ":return "オ"
        case "ヵ":return "カ"
        case "ヶ":return "ケ"
        case "ッ":return "ツ"
        case "ャ":return "ヤ"
        case "ュ":return "ユ"
        case "ョ":return "ヨ"
        case "ヮ":return "ワ"
        default: return self
        }
    }

    var isDakuten: Bool {
        return Character.dakutenKana.contains(self)
    }
    
    var dakuten: Character {
        switch self{
        case"う":return "ゔ"
        case"か":return "が"
        case"き":return "ぎ"
        case"く":return "ぐ"
        case"け":return "げ"
        case"こ":return "ご"
        case"さ":return "ざ"
        case"し":return "じ"
        case"す":return "ず"
        case"せ":return "ぜ"
        case"そ":return "ぞ"
        case"た":return "だ"
        case"ち":return "ぢ"
        case"つ":return "づ"
        case"て":return "で"
        case"と":return "ど"
        case"は":return "ば"
        case"ひ":return "び"
        case"ふ":return "ぶ"
        case"へ":return "べ"
        case"ほ":return "ぼ"
        case"ウ":return "ヴ"
        case"カ":return "ガ"
        case"キ":return "ギ"
        case"ク":return "グ"
        case"ケ":return "ゲ"
        case"コ":return "ゴ"
        case"サ":return "ザ"
        case"シ":return "ジ"
        case"ス":return "ズ"
        case"セ":return "ゼ"
        case"ソ":return "ゾ"
        case"タ":return "ダ"
        case"チ":return "ヂ"
        case"ツ":return "ヅ"
        case"テ":return "デ"
        case"ト":return "ド"
        case"ハ":return "バ"
        case"ヒ":return "ビ"
        case"フ":return "ブ"
        case"ヘ":return "ベ"
        case"ホ":return "ボ"
        default: return self
        }
    }
    
    var mudakuten: Character {
        switch self{
        case"ゔ":return "う"
        case"が":return "か"
        case"ぎ":return "き"
        case"ぐ":return "く"
        case"げ":return "け"
        case"ご":return "こ"
        case"ざ":return "さ"
        case"じ":return "し"
        case"ず":return "す"
        case"ぜ":return "せ"
        case"ぞ":return "そ"
        case"だ":return "た"
        case"ぢ":return "ち"
        case"づ":return "つ"
        case"で":return "て"
        case"ど":return "と"
        case"ば":return "は"
        case"び":return "ひ"
        case"ぶ":return "ふ"
        case"べ":return "へ"
        case"ぼ":return "ほ"
        case"ヴ":return "ウ"
        case"ガ":return "カ"
        case"ギ":return "キ"
        case"グ":return "ク"
        case"ゲ":return "ケ"
        case"ゴ":return "コ"
        case"ザ":return "サ"
        case"ジ":return "シ"
        case"ズ":return "ス"
        case"ゼ":return "セ"
        case"ゾ":return "ソ"
        case"ダ":return "タ"
        case"ヂ":return "チ"
        case"ヅ":return "ツ"
        case"デ":return "テ"
        case"ド":return "ト"
        case"バ":return "ハ"
        case"ビ":return "ヒ"
        case"ブ":return "フ"
        case"ベ":return "ヘ"
        case"ボ":return "ホ"
        default: return self
        }
    }

    var isHandakuten: Bool {
        return [
            "ぱ", "ぴ", "ぷ", "ぺ", "ぽ",
            "パ", "ピ", "プ", "ペ", "ポ"
        ].contains(self)
    }

    var handakuten: Character {
        switch self{
        case"は":return "ぱ"
        case"ひ":return "ぴ"
        case"ふ":return "ぷ"
        case"へ":return "ぺ"
        case"ほ":return "ぽ"
        case"ハ":return "パ"
        case"ヒ":return "ピ"
        case"フ":return "プ"
        case"ヘ":return "ペ"
        case"ホ":return "ポ"
        default: return self
        }
    }
    
    var muhandakuten: Character {
        switch self{
        case"ぱ":return "は"
        case"ぴ":return "ひ"
        case"ぷ":return "ふ"
        case"ぺ":return "へ"
        case"ぽ":return "ほ"
        case"パ":return "ハ"
        case"ピ":return "ヒ"
        case"プ":return "フ"
        case"ペ":return "ヘ"
        case"ポ":return "ホ"
        default: return self
        }
    }

    ///濁点、小書き、半濁点などを相互に変換する関数。
    /// - Parameters:
    ///   - character: 変換対象の文字。
    func requestChange() -> String {
        if self.isLowercase{
            return self.uppercased()
        }
        if self.isUppercase{
            return self.lowercased()
        }

        if Set(["あ", "い", "え", "お", "や", "ゆ", "よ", "わ"]).contains(self){
            return String(self.kogaki)
        }

        if Set(["ぁ", "ぃ", "ぇ", "ぉ", "ゃ", "ゅ", "ょ", "ゎ"]).contains(self){
            return String(self.ogaki)
        }

        if Set(["か", "き", "く", "け", "こ", "さ", "し", "す", "せ", "そ", "た", "ち", "て", "と"]).contains(self){
            return String(self.dakuten)
        }

        if Set(["が", "ぎ", "ぐ", "げ", "ご", "ざ", "じ", "ず", "ぜ", "ぞ", "だ", "ぢ", "で", "ど"]).contains(self){
            return String(self.mudakuten)
        }

        if Set(["つ", "う"]).contains(self){
            return String(self.kogaki)
        }

        if Set(["っ", "ぅ"]).contains(self){
            return String(self.ogaki.dakuten)
        }

        if Set(["づ", "ゔ"]).contains(self){
            return String(self.mudakuten)
        }

        if Set(["は", "ひ", "ふ", "へ", "ほ"]).contains(self){
            return String(self.dakuten)
        }

        if Set(["ば", "び", "ぶ", "べ", "ぼ"]).contains(self){
            return String(self.mudakuten.handakuten)
        }

        if Set(["ぱ", "ぴ", "ぷ", "ぺ", "ぽ"]).contains(self){
            return String(self.muhandakuten)
        }

        return String(self)
    }


}