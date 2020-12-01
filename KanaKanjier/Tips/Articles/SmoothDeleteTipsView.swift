//
//  SmoothDeleteTipsView.swift
//  KanaKanjier
//
//  Created by β α on 2020/11/03.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation
import SwiftUI

struct SmoothDeleteTipsView: View {
    var body: some View {
        TipsContentView("文頭まで削除する"){
            TipsContentParagraph{
                Text("フリックのキーボードでは削除\(Image(systemName: "delete.left"))キーを左にフリックすると、文頭まで削除することができます。")
                TipsImage("smoothDelete")
                Text("誤って削除してしまった場合は端末を振るか、入力欄を三本指でスワイプすることで取り消し操作を行うことが可能です。")
            }
        }
    }
}