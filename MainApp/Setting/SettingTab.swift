//
//  SettingTab.swift
//  MainApp
//
//  Created by ensan on 2020/09/16.
//  Copyright © 2020 ensan. All rights reserved.
//

import AzooKeyUtils
import KeyboardViews
import StoreKit
import SwiftUI

struct SettingTabView: View {
    @State private var searchQuery: String = ""
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject private var appStates: MainAppStates
    private func canFlickLayout(_ layout: LanguageLayout) -> Bool {
        if layout == .flick {
            return true
        }
        if case .custard = layout {
            return true
        }
        return false
    }

    private func canQwertyLayout(_ layout: LanguageLayout) -> Bool {
        if layout == .qwerty {
            return true
        }
        return false
    }

    private func isCustard(_ layout: LanguageLayout) -> Bool {
        if case .custard = layout {
            return true
        }
        return false
    }

    var body: some View {
        NavigationView {
            Form {
                Section("キーボードの種類") {
                    NavigationLink("キーボードの種類を設定する", destination: KeyboardLayoutTypeDetailsView())
                }
                .searchKeys("キーボードの種類", "レイアウト", "フリック", "ローマ字")

                Section("ライブ変換") {
                    BoolSettingView(.liveConversion)
                    NavigationLink("詳しい設定", destination: LiveConversionSettingView())
                }
                .searchKeys("ライブ変換", "自動変換", "自動確定")

                Section("カスタムキー") {
                    CustomKeysSettingView()
                        .searchKeys("カスタムキー", "カスタマイズ")
                    if !self.isCustard(appStates.japaneseLayout) || !self.isCustard(appStates.englishLayout) {
                        BoolSettingView(.useNextCandidateKey)
                            .searchKeys("次候補キー")
                    }
                    if self.canQwertyLayout(appStates.englishLayout) {
                        BoolSettingView(.useShiftKey)
                            .searchKeys("シフトキー")
                        // Version 2.2.2以前にインストールしており、UseShiftKey.valueがtrueの人にのみこのオプションを表示する
                        if #unavailable(iOS 18), let initialVersion = SharedStore.initialAppVersion, initialVersion <= .azooKey_v2_2_2, UseShiftKey.value == true {
                            BoolSettingView(.keepDeprecatedShiftKeyBehavior)
                                .searchKeys("シフトキー")
                        }
                    }
                    if !SemiStaticStates.shared.needsInputModeSwitchKey, self.canFlickLayout(appStates.japaneseLayout) {
                        BoolSettingView(.enablePasteButton)
                            .searchKeys("ペーストボタン", "ペーストキー", "貼り付け")
                    }
                }
                .inheritSearchKeys()

                Section("バー") {
                    BoolSettingView(.useReflectStyleCursorBar)
                        .searchKeys("カーソルバー", "バー")
                    BoolSettingView(.displayTabBarButton)
                        .searchKeys("タブバー", "バー", "タブバーボタン")
                    BoolSettingView(.enableClipboardHistoryManagerTab)
                        .searchKeys("コピー履歴", "クリップボード履歴", "履歴")
                    if SemiStaticStates.shared.hasFullAccess {
                        NavigationLink("「ペーストを許可」のダイアログについて", destination: PasteFromOtherAppsPermissionTipsView())
                            .searchKeys("ペースト", "コピー履歴", "クリップボード履歴", "履歴")
                    }
                    NavigationLink("タブバーを編集", destination: EditingTabBarView(manager: $appStates.custardManager))
                        .searchKeys("タブバー", "バー")
                }
                .inheritSearchKeys()

                // デバイスが触覚フィードバックをサポートしている場合のみ表示する
                if SemiStaticStates.shared.hapticsAvailable {
                    Section("サウンドと振動") {
                        BoolSettingView(.enableKeySound)
                            .searchKeys("サウンド", "音")
                        BoolSettingView(.enableKeyHaptics)
                            .searchKeys("サウンド", "振動")
                    }
                    .inheritSearchKeys()
                } else {
                    Section("サウンド") {
                        BoolSettingView(.enableKeySound)
                    }
                    .searchKeys("サウンド", "音")
                }

                Section("表示") {
                    KeyboardHeightSettingView(.keyboardHeightScale)
                        .searchKeys("高さ", "大きさ", "サイズ")
                    FontSizeSettingView(.keyViewFontSize, .key, availableValueRange: 15 ... 28)
                        .searchKeys("フォント", "サイズ", "文字サイズ")
                    FontSizeSettingView(.resultViewFontSize, .result, availableValueRange: 12...24)
                        .searchKeys("フォント", "サイズ", "文字サイズ")
                }
                .inheritSearchKeys()

                Section("操作性") {
                    BoolSettingView(.hideResetButtonInOneHandedMode)
                        .searchKeys("片手モード", "解除ボタン")
                    if self.canFlickLayout(appStates.japaneseLayout) {
                        FlickSensitivitySettingView(.flickSensitivity)
                            .searchKeys("フリックの感度", "感度")
                    }
                }
                .inheritSearchKeys()

                Section("変換") {
                    BoolSettingView(.englishCandidate)
                        .searchKeys("英単語変換", "変換", "英語", "英語変換")
                    BoolSettingView(.halfKanaCandidate)
                        .searchKeys("半角カナ", "半角カタカナ", "カタカナ")
                    BoolSettingView(.fullRomanCandidate)
                        .searchKeys("全角", "全角アルファベット", "アルファベット", "数字", "全角数字")
                    BoolSettingView(.typographyLetter)
                        .searchKeys("太字", "フォント", "タイポグラフィ", "装飾文字")
                    BoolSettingView(.unicodeCandidate)
                        .searchKeys("Unicode", "文字コード", "ユニコード")
                    MarkedTextSettingView(.markedTextSetting)
                        .searchKeys("入力中のテキストを保護", "下線", "テキストを保護")
                    ContactImportSettingView()
                        .searchKeys("連絡先変換", "氏名", "知り合い")
                    NavigationLink("絵文字と顔文字", destination: AdditionalDictManageView())
                        .searchKeys("絵文字", "顔文字", "特殊文字")
                }
                .inheritSearchKeys()

                Section("言語") {
                    PreferredLanguageSettingView()
                }
                .searchKeys("言語", "第一言語", "第二言語")

                Section("ユーザ辞書") {
                    BoolSettingView(.useOSUserDict)
                        .searchKeys("ユーザ辞書", "追加辞書")
                    NavigationLink("azooKeyユーザ辞書", destination: AzooKeyUserDictionaryView())
                        .searchKeys("ユーザ辞書", "追加辞書")
                }
                .inheritSearchKeys()

                Section("テンプレート") {
                    NavigationLink("テンプレートの管理", destination: TemplateListView())
                }
                .searchKeys("テンプレート", "時間", "乱数", "ランダム")

                Section("学習機能") {
                    LearningTypeSettingView()
                        .searchKeys("学習", "履歴")
                    MemoryResetSettingItemView()
                        .searchKeys("リセット", "学習", "履歴")
                }
                .inheritSearchKeys()

                Section("カスタムタブ") {
                    NavigationLink("カスタムタブの管理", destination: ManageCustardView(manager: $appStates.custardManager))
                }
                .searchKeys("カスタムタブ", "タブ", "カスタマイズ")

                Section("オープンソースソフトウェア") {
                    Text("azooKeyはオープンソースソフトウェアであり、GitHubでソースコードを公開しています。")
                    FallbackLink("View azooKey on GitHub", destination: URL(string: "https://github.com/ensan-hcl/azooKey")!)
                    NavigationLink("Acknowledgements", destination: OpenSourceSoftwaresLicenseView())
                }
                .searchKeys("オープンソース", "ライセンス", "謝辞", "OSS", "ソフトウェア")

                Section("このアプリについて") {
                    NavigationLink("お問い合わせ", destination: ContactView())
                        .searchKeys("お問い合わせ", "質問", "連絡", "メール")
                    FallbackLink("プライバシーポリシー", destination: URL(string: "https://azookey.netlify.app/PrivacyPolicy")!)
                        .foregroundStyle(.primary)
                        .searchKeys("プライバシーポリシー", "個人情報", "ライセンス")
                    FallbackLink("利用規約", destination: URL(string: "https://azookey.netlify.app/TermsOfService")!)
                        .foregroundStyle(.primary)
                        .searchKeys("利用規約", "規約", "ライセンス")
                    NavigationLink("更新履歴", destination: UpdateInformationView())
                        .searchKeys("更新履歴", "アップデート情報", "変更", "バージョン")
                    HStack {
                        Text("URL Scheme")
                        Spacer()
                        Text(verbatim: "azooKey://").font(.system(.body, design: .monospaced))
                    }
                    .searchKeys("URLスキーム")
                    HStack {
                        Text("バージョン")
                        Spacer()
                        Text(verbatim: SharedStore.currentAppVersion?.description ?? "取得中です")
                    }
                    .searchKeys("バージョン")
                }
                .inheritSearchKeys()

            }
            .searchQuery(searchQuery.isEmpty ? nil : searchQuery.toKatakana())
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if appStates.requestReviewManager.shouldTryRequestReview, appStates.requestReviewManager.shouldRequestReview() {
                    requestReview()
                }
            }
        }
        .navigationViewStyle(.stack)
        .searchable(text: $searchQuery, prompt: Text("検索"))
    }
}
