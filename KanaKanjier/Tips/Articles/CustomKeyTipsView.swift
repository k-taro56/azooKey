//
//  CustomKeyTipsView.swift
//  KanaKanjier
//
//  Created by β α on 2020/11/21.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import SwiftUI

struct CustomKeyTipsView: View {
    var body: some View {
        TipsContentView("キーをカスタマイズする"){
            TipsContentParagraph{
                Text("azooKeyでは一部キーのカスタマイズが可能です。")
            }

            TipsContentParagraph{
                Text("フリック入力では、ひらがなタブの「小ﾞﾟ」キーのフリックに最大3方向まで好きな文字を登録することができます。")
                ImageSlideshowView(pictures: ["flickCustomKeySetting0","flickCustomKeySetting1","flickCustomKeySetting2"])

            }

            TipsContentParagraph{
                Text("ローマ字入力では、数字タブの一部キーに好きな文字と長押ししたときの候補を登録することができます。")
                ImageSlideshowView(pictures: ["romanCustomKeySetting0","romanCustomKeySetting1","romanCustomKeySetting2"])

            }

        }

    }
}