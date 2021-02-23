//
//  CustardData.swift
//  KanaKanjier
//
//  Created by β α on 2021/02/18.
//  Copyright © 2021 DevEn3. All rights reserved.
//

import Foundation

enum CustardLanguage: String, Codable {
    case english
    case japanese
    case undefined
}

enum CustardInputStyle: String, Codable {
    case direct
    case roman2kana
}

enum CustardVersion: String, Codable {
    case v1_0
}

struct Custard: Codable {
    let custard_version: CustardVersion
    let identifier: String
    let display_name: String
    let language: CustardLanguage
    let input_style: CustardInputStyle
    let interface: CustardInterface
}

enum CustardInterfaceStyle: String, Codable {
    case flick
    case qwerty
}

enum CustardInterfaceLayout: Codable {
    ///画面いっぱいにマス目状で均等に配置されます。
    case gridFit(CustardInterfaceLayoutGridValue)
    ///はみ出した分はスクロールできる形でマス目状に均等に配置されます。
    case gridScroll(CustardInterfaceLayoutScrollValue)
}

struct CustardInterfaceLayoutGridValue: Codable {
    ///横方向に配置するキーの数。3以上を推奨。
    let width: Int
    ///縦方向に配置するキーの数。4以上を推奨。
    let height: Int
}

struct CustardInterfaceLayoutScrollValue: Codable {
    ///スクロールの方向
    let direction: ScrollDirection
    ///一列に配置するキーの数
    let columnKeyCount: Int
    ///画面内に収まるスクロール方向のキーの数
    let screenRowKeyCount: Double

    enum ScrollDirection: String, Codable{
        case vertical
        case horizontal
    }
}


extension CustardInterfaceLayout{
    enum CodingKeys: CodingKey{
        case grid_fit
        case grid_scroll
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .gridFit(value):
            try container.encode(value, forKey: .grid_fit)
        case let .gridScroll(value):
            try container.encode(value, forKey: .grid_scroll)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else{
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
        switch key {
        case .grid_fit:
            let value = try container.decode(
                CustardInterfaceLayoutGridValue.self,
                forKey: .grid_fit
            )
            self = .gridFit(value)
        case .grid_scroll:
            let value = try container.decode(
                CustardInterfaceLayoutScrollValue.self,
                forKey: .grid_scroll
            )
            self = .gridScroll(value)
        }
    }
}

struct GridFitPositionSpecifier: Codable, Hashable {
    let x: Int
    let y: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

enum CustardKeyPositionSpecifier: Codable, Hashable {
    case grid_fit(GridFitPositionSpecifier)
    case grid_scroll(GridScrollPositionSpecifier)
}

struct GridScrollPositionSpecifier: Codable, Hashable {
    let index: Int

    init(_ index: Int){
        self.index = index
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}

extension GridScrollPositionSpecifier: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int

    init(integerLiteral value: Int) {
        self.index = value
    }
}

extension CustardKeyPositionSpecifier {
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .grid_fit(value):
            hasher.combine(CodingKeys.grid_fit)
            hasher.combine(value)
        case let .grid_scroll(value):
            hasher.combine(CodingKeys.grid_scroll)
            hasher.combine(value)
        }
    }
}

extension CustardKeyPositionSpecifier{
    enum CodingKeys: CodingKey{
        case grid_fit
        case grid_scroll
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .grid_fit(value):
            try container.encode(value, forKey: .grid_fit)
        case let .grid_scroll(value):
            try container.encode(value, forKey: .grid_scroll)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else{
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
        switch key {
        case .grid_fit:
            let value = try container.decode(
                GridFitPositionSpecifier.self,
                forKey: .grid_fit
            )
            self = .grid_fit(value)
        case .grid_scroll:
            let value = try container.decode(
                GridScrollPositionSpecifier.self,
                forKey: .grid_scroll
            )
            self = .grid_scroll(value)
        }
    }
}

struct CustardInterface: Codable {
    let key_style: CustardInterfaceStyle
    let key_layout: CustardInterfaceLayout
    let keys: [CustardKeyPositionSpecifier: CustardInterfaceKey]
}

enum CustardKeyLabelStyle: Codable {
    case text(String)
    case systemImage(String)
}

extension CustardKeyLabelStyle{
    enum CodingKeys: CodingKey{
        case text
        case systemImage
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .text(value):
            try container.encode(value, forKey: .text)
        case let .systemImage(value):
            try container.encode(value, forKey: .systemImage)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else{
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
        switch key {
        case .text:
            let value = try container.decode(
                String.self,
                forKey: .text
            )
            self = .text(value)
        case .systemImage:
            let value = try container.decode(
                String.self,
                forKey: .systemImage
            )
            self = .systemImage(value)
        }
    }
}

struct CustardKeyDesign: Codable {
    let label: CustardKeyLabelStyle
    let color: ColorType

    enum ColorType: String, Codable{
        case normal
        case special
    }
}

enum CustardKeyVariationType: Codable {
    case flick(FlickDirection)
    case variations
}

extension CustardKeyVariationType{
    enum CodingKeys: CodingKey{
        case flick
        case variations
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .flick(flickDirection):
            try container.encode(flickDirection, forKey: .flick)
        case .variations:
            try container.encode(true, forKey: .variations)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else{
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
        switch key {
        case .flick:
            let direction = try container.decode(
                FlickDirection.self,
                forKey: .flick
            )
            self = .flick(direction)
        case .variations:
            self = .variations
        }
    }
}

enum CustardInterfaceSystemKey: String, Codable {
    case change_keyboard
    case enter
}

enum CustardInterfaceKey: Codable {
    case system(CustardInterfaceSystemKey)
    case custom(CustardInterfaceCustomKey)
}

extension CustardInterfaceKey{
    enum CodingKeys: CodingKey{
        case system
        case custom
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .system(value):
            try container.encode(value, forKey: .system)
        case let .custom(value):
            try container.encode(value, forKey: .custom)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let key = container.allKeys.first else{
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
        switch key {
        case .system:
            let value = try container.decode(
                CustardInterfaceSystemKey.self,
                forKey: .system
            )
            self = .system(value)
        case .custom:
            let value = try container.decode(
                CustardInterfaceCustomKey.self,
                forKey: .custom
            )
            self = .custom(value)
        }
    }
}

struct CustardInterfaceCustomKey: Codable {
    let design: CustardKeyDesign
    let press_action: [CodableActionData]
    let longpress_action: [CodableActionData]
    let variation: [CustardInterfaceVariation]
}

struct CustardInterfaceVariation: Codable {
    let type: CustardKeyVariationType
    let key: CustardInterfaceVariationKey
}

struct CustardInterfaceVariationKey: Codable {
    let label: CustardKeyLabelStyle
    let press_action: [CodableActionData]
    let longpress_action: [CodableActionData]
}

extension Custard{

    static let hieroglyph: Custard = {
        let hieroglyphs = Array(String.UnicodeScalarView((UInt32(0x13000)...UInt32(0x133FF)).compactMap(UnicodeScalar.init))).map(String.init)

        var keys: [CustardKeyPositionSpecifier: CustardInterfaceKey] = [
            .grid_scroll(0): .system(.change_keyboard),
            .grid_scroll(1): .custom(
                .init(
                    design: .init(label: .text("←"), color: .special),
                    press_action: [.moveCursor(-1)],
                    longpress_action: [.moveCursor(-1)],
                    variation: []
                )
            ),
            .grid_scroll(2): .custom(
                .init(
                    design: .init(label: .systemImage("list.dash"), color: .special),
                    press_action: [.toggleTabBar],
                    longpress_action: [],
                    variation: []
                )
            ),
            .grid_scroll(3): .custom(
                .init(
                    design: .init(label: .text("→"), color: .special),
                    press_action: [.moveCursor(1)],
                    longpress_action: [.moveCursor(1)],
                    variation: []
                )
            ),
            .grid_scroll(4): .custom(
                .init(
                    design: .init(label: .systemImage("delete.left"), color: .special),
                    press_action: [.delete(1)],
                    longpress_action: [.delete(1)],
                    variation: []
                )
            ),
        ]

        hieroglyphs.indices.forEach{
            keys[.grid_scroll(GridScrollPositionSpecifier(5+$0))] = .custom(
                .init(
                    design: .init(label: .text(hieroglyphs[$0]), color: .normal),
                    press_action: [.input(hieroglyphs[$0])],
                    longpress_action: [],
                    variation: []
                )
            )
        }

        let custard = Custard(
            custard_version: .v1_0,
            identifier: "Hieroglyphs",
            display_name: "ヒエログリフ",
            language: .undefined,
            input_style: .direct,
            interface: .init(
                key_style: .flick,
                key_layout: .gridScroll(.init(direction: .vertical, columnKeyCount: 8, screenRowKeyCount: 4.2)),
                keys: keys
            )
        )
        return custard
    }()

    static let mock_flick_grid = Custard(
        custard_version: .v1_0,
        identifier: "my_custard",
        display_name: "マイカスタード",
        language: .japanese,
        input_style: .direct,
        interface: .init(
            key_style: .flick,
            key_layout: .gridFit(.init(width: 3, height: 5)),
            keys: [
                .grid_fit(.init(x: 0, y: 0)): .system(.change_keyboard),
                .grid_fit(.init(x: 1, y: 0)): .custom(
                    .init(
                        design: .init(label: .text("←"), color: .special),
                        press_action: [.moveCursor(-1)],
                        longpress_action: [.moveCursor(-1)],
                        variation: []
                    )
                ),
                .grid_fit(.init(x: 2, y: 0)): .custom(
                    .init(
                        design: .init(label: .text("→"), color: .special),
                        press_action: [.moveCursor(1)],
                        longpress_action: [.moveCursor(1)],
                        variation: []
                    )
                ),
                .grid_fit(.init(x: 0, y: 1)): .custom(
                    .init(
                        design: .init(label: .text("①"), color: .normal),
                        press_action: [.input("①")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 1, y: 1)): .custom(
                    .init(
                        design: .init(label: .text("②"), color: .normal),
                        press_action: [.input("②")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 2, y: 1)): .custom(
                    .init(
                        design: .init(label: .text("③"), color: .normal),
                        press_action: [.input("③")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 0, y: 2)): .custom(
                    .init(
                        design: .init(label: .text("④"), color: .normal),
                        press_action: [.input("④")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 1, y: 2)): .custom(
                    .init(
                        design: .init(label: .text("⑤"), color: .normal),
                        press_action: [.input("⑤")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 2, y: 2)): .custom(
                    .init(
                        design: .init(label: .text("⑥"), color: .normal),
                        press_action: [.input("⑥")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 0, y: 3)): .custom(
                    .init(
                        design: .init(label: .text("⑦"), color: .normal),
                        press_action: [.input("⑦")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 1, y: 3)): .custom(
                    .init(
                        design: .init(label: .text("⑧"), color: .normal),
                        press_action: [.input("⑧")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 2, y: 3)): .custom(
                    .init(
                        design: .init(label: .text("⑨"), color: .normal),
                        press_action: [.input("⑨")],
                        longpress_action: [],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                ),
                .grid_fit(.init(x: 0, y: 4)): .custom(
                    .init(
                        design: .init(label: .text("空白"), color: .special),
                        press_action: [.input(" ")],
                        longpress_action: [.toggleCursorMovingView],
                        variation: []
                    )
                ),
                .grid_fit(.init(x: 1, y: 4)): .system(.enter),
                .grid_fit(.init(x: 2, y: 4)): .custom(
                    .init(
                        design: .init(label: .systemImage("delete.left"), color: .special),
                        press_action: [.delete(1)],
                        longpress_action: [.delete(1)],
                        variation: [
                            .init(
                                type: .flick(.left),
                                key: .init(
                                    label: .text("❌"),
                                    press_action: [.smoothDelete],
                                    longpress_action: []
                                )
                            )
                        ]
                    )
                )
            ]
        )
    )
}