//
//  ThemeTab.swift
//  KanaKanjier
//
//  Created by β α on 2021/02/04.
//  Copyright © 2021 DevEn3. All rights reserved.
//

import SwiftUI

struct ThemeTabView: View {
    @ObservedObject private var storeVariableSection = Store.variableSection
    @State private var refresh = false
    @State private var manager = ThemeIndexManager.load()

    @State private var editViewIndex: Int?
    @State private var editViewEnabled = false

    private func theme(at index: Int) -> ThemeData? {
        do {
            return try manager.theme(at: index)
        } catch {
            debug(error)
            return nil
        }
    }

    @ViewBuilder private func circle(geometry: GeometryProxy, systemName: String, color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(idealWidth: geometry.size.width / 1.5, maxWidth: 180, idealHeight: geometry.size.width / 1.5, maxHeight: 180)
            .overlay(
                Image(systemName: systemName)
                    .font(Font.system(size: min(geometry.size.width / 3, 90)).weight(.bold))
                    .foregroundColor(.white)
            )
    }

    private var listSection: some View {
        ForEach(manager.indices.reversed(), id: \.self) { index in
            if let theme = theme(at: index) {
                HStack {
                    KeyboardPreview(theme: theme, scale: 0.6)
                        .disabled(true)
                    GeometryReader {geometry in
                        if manager.selectedIndex == manager.selectedIndexInDarkMode {
                            CenterAlignedView {
                                VStack {
                                    Spacer()
                                    circle(geometry: geometry, systemName: "checkmark", color: manager.selectedIndex == index ? Color.blue : Color.systemGray4)
                                    Spacer()
                                }
                                .onTapGesture {
                                    manager.select(at: index)
                                }
                            }
                        } else {
                            CenterAlignedView {
                                VStack {
                                    Spacer()
                                    circle(geometry: geometry, systemName: "sun.max.fill", color: manager.selectedIndex == index ? Color.blue : Color.systemGray4)
                                        .padding()
                                        .onTapGesture {
                                            manager.selectForLightMode(at: index)
                                        }
                                    circle(geometry: geometry, systemName: "moon.fill", color: manager.selectedIndexInDarkMode == index ? Color.blue : Color.systemGray4)
                                        .padding()
                                        .onTapGesture {
                                            manager.selectForDarkMode(at: index)
                                        }
                                    Spacer()
                                }
                            }

                        }
                    }
                    if editViewIndex == index {
                        NavigationLink(destination: ThemeEditView(index: editViewIndex, manager: $manager), isActive: $editViewEnabled) {
                            EmptyView()
                        }.frame(maxWidth: 1)
                    }
                }
                .contextMenu {
                    if self.manager.selectedIndex == self.manager.selectedIndexInDarkMode {
                        Button {
                            manager.selectForLightMode(at: index)
                        } label: {
                            Image(systemName: "sun.max.fill")
                            // TODO: Localize
                            Text("ライトモードで使用")
                        }
                        Button {
                            manager.selectForDarkMode(at: index)
                        } label: {
                            Image(systemName: "moon.fill")
                            // TODO: Localize
                            Text("ダークモードで使用")
                        }
                    }
                    Button {
                        editViewIndex = index
                        editViewEnabled = true
                    } label: {
                        Image(systemName: "pencil")
                        Text("編集する")
                    }.disabled(index == 0)
                    Button {
                        manager.remove(index: index)
                    } label: {
                        Label("削除する", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    .disabled(index == 0)
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("作る")) {
                    HStack {
                        Button("着せ替えを作成") {
                            editViewIndex = nil
                            editViewEnabled = true
                        }
                        .foregroundColor(.primary)
                        if editViewIndex == nil {
                            NavigationLink(destination: ThemeEditView(index: editViewIndex, manager: $manager), isActive: $editViewEnabled) {
                                EmptyView()
                            }
                        }
                    }
                }
                Section(header: Text("選ぶ")) {
                    if refresh {
                        listSection
                    } else {
                        listSection
                    }
                }
            }
            .navigationBarTitle(Text("着せ替え"), displayMode: .large)
            .onAppear {
                // この位置にonAppearを置く。NavigationViewは画面の遷移中常に現れている。
                self.refresh.toggle()
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: storeVariableSection.japaneseLayout) {_ in
            self.refresh.toggle()
        }
    }
}
