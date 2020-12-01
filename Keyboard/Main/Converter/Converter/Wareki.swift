//
//  extension Converter.swift
//  Keyboard
//
//  Created by β α on 2020/09/11.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation


extension KanaKanjiConverter{
    private func makeResult<S: StringProtocol>(_ ruby: S, _ string: String) -> Candidate {
        let ruby = String(ruby)
        return Candidate(
            text: string,
            value: -18,
            visibleString: ruby,
            rcid: 1285,
            lastMid: 237,
            data: [LRE_DicDataElement(word: string, ruby: ruby, cid: 1285, mid: 237, value: -18)]
        )
    }

    func toSeireki<S: StringProtocol>(string: S) -> [Candidate] {
        let count = string.count
        if string == "メイジガンネン"{
            return [
                makeResult(string, "1868年")
            ]
        }
        if string == "タイショウガンネン"{
            return [
                makeResult(string, "1912年")
            ]
        }
        if string == "ショウワガンネン"{
            return [
                makeResult(string, "1926年")
            ]
        }
        if string == "ヘイセイガンネン"{
            return [
                makeResult(string, "1989年")
            ]
        }
        if string == "レイワガンネン"{
            return [
                makeResult(string, "2019年")
            ]
        }
        if !string.hasSuffix("ネン"){
            return []
        }
        if string.hasPrefix("ショウワ"){
            if count == 8, let year = Int(string[4...5]){
                return [
                    makeResult(string, "\(year + 1925)年")
                ]
            }
            if count == 7, let year = Int(string[4...4]){
                return [
                    makeResult(string, "\(year + 1925)年")
                ]
            }
        }
        if string.hasPrefix("ヘイセイ"){
            if count == 8, let year = Int(string[4...5]){
                return [
                    makeResult(string, "\(year + 1988)年")
                ]
            }
            if count == 7, let year = Int(string[4...4]){
                return [
                    makeResult(string, "\(year + 1988)年")
                ]
            }
        }
        if string.hasPrefix("レイワ"){
            if count == 7, let year = Int(string[3...4]){
                return [
                    makeResult(string, "\(year + 2018)年")
                ]
            }
            if count == 6, let year = Int(string[3...3]){
                return [
                    makeResult(string, "\(year + 2018)年")
                ]
            }
        }
        if string.hasPrefix("メイジ"){
            if count == 7, let year = Int(string[3...4]){
                return [
                    makeResult(string, "\(year + 1867)年")
                ]
            }
            if count == 6, let year = Int(string[3...3]){
                return [
                    makeResult(string, "\(year + 1867)年")
                ]
            }
        }
        
        if string.hasPrefix("タイショウ"){
            if count == 9, let year = Int(string[5...6]){
                return [
                    makeResult(string, "\(year + 1911)年")
                ]
            }
            if count == 8, let year = Int(string[5...5]){
                return [
                    makeResult(string, "\(year + 1911)年")
                ]
            }
        }
        return []

    }

    func toWareki<S: StringProtocol>(string: S) -> [Candidate] {
        let makeResult0: (String) -> Candidate = {
            let string = String(string)
            return Candidate(
                text: $0,
                value: -18,
                visibleString: string,
                rcid: 1285,
                lastMid: 237,
                data: [LRE_DicDataElement(word: $0, ruby: string, cid: 1285, mid: 237, value: -18)]
            )
        }
        let makeResult1: (String) -> Candidate = {
            let string = String(string)
            return Candidate(
                text: $0,
                value: -19,
                visibleString: string,
                rcid: 1285,
                lastMid: 237,
                data: [LRE_DicDataElement(word: $0, ruby: string, cid: 1285, mid: 237, value: -19)]
            )
        }

        guard let seireki = Int(string.prefix(4)) else{
            return []
        }
        if !string.hasSuffix("ネン"){
            return []
        }
        if seireki == 1989{
            return [
                makeResult0("平成元年"),
                makeResult1("昭和64年")
            ]
        }
        if seireki == 2019{
            return [
                makeResult0("令和元年"),
                makeResult1("平成31年")
            ]
        }
        if seireki == 1926{
            return [
                makeResult0("昭和元年"),
                makeResult1("大正15年")
            ]
        }
        if seireki == 1912{
            return [
                makeResult0("大正元年"),
                makeResult1("明治45年")
            ]
        }
        if seireki == 1868{
            return [
                makeResult0("明治元年"),
                makeResult1("慶應4年")
            ]

        }
        if (1990...2018).contains(seireki){
            let i = seireki-1988
            return [
                makeResult0("平成\(i)年"),
            ]
        }
        if (1927...1988).contains(seireki){
            let i = seireki-1925
            return [
                makeResult0("昭和\(i)年"),
            ]
        }
        if (1869...1911).contains(seireki){
            let i = seireki-1967
            return [
                makeResult0("明治\(i)年"),
            ]
        }
        if (1912...1926).contains(seireki){
            let i = seireki-1911
            return [
                makeResult0("大正\(i)年"),
            ]
        }
        if 2020<=seireki{
            let i = seireki-2018
            return [
                makeResult0("令和\(i)年"),
            ]
        }
        return []
    }

}