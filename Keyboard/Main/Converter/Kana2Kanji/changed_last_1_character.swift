//
//  afterLastCharacterChanged.swift
//  Keyboard
//
//  Created by β α on 2020/09/14.
//  Copyright © 2020 DevEn3. All rights reserved.
//

import Foundation
extension Kana2Kanji{
    ///カナを漢字に変換する関数, 最後の一文字が変わった場合。
    ///### 実装状況
    ///(0)多用する変数の宣言。
    ///
    ///(1)まず、変更前の一文字につながるノードを全て削除する。
    ///
    ///(2)次に、変更後の一文字につながるノードを全て列挙する。
    ///
    ///(3)(1)を解析して(2)にregisterしていく。
    ///
    ///(4)registerされた結果をresultノードに追加していく。
    ///
    ///(5)ノードをアップデートした上で返却する。

    func kana2lattice_changedLast(_ inputData: InputData, N_best: Int, previousNodes: Nodes) -> (result: LatticeNode, nodes: Nodes) {
        //(0)
        let count = inputData.count

        //(1)
        let nodes = previousNodes.indices.map{(i: Int) in
            return previousNodes[i].filter{i + $0.rubyCount < count}
        }
        
        //(2)
        let addedNodes: [[LatticeNode]] = (0..<count).map{(i: Int) in
            if count-i >= self.dicdataStore.maxlength{
                return []
            }
            return self.dicdataStore.getLOUDSData(inputData: inputData, from: i, to: count-1)
        }
        
        //(3)
        nodes.indices.forEach{(i: Int) in
            nodes[i].forEach{(node: LatticeNode) in
                if node.prevs.isEmpty{
                    return
                }
                if self.dicdataStore.shouldBeRemoved(data: node.data){
                    return
                }

                //変換した文字数
                let nextIndex = node.rubyCount + i
                addedNodes[nextIndex].forEach{(nextnode: LatticeNode) in
                    //この関数はこの時点で呼び出して、後のnode.registered.isEmptyで最終的に弾くのが良い。
                    if self.dicdataStore.shouldBeRemoved(data: nextnode.data){
                        return
                    }
                    //クラスの連続確率を計算する。
                    let ccValue = self.dicdataStore.getCCValue(node.data.rcid, nextnode.data.lcid)
                    let ccBonus = PValue(self.dicdataStore.getMatch(node.data, next: nextnode.data) * self.ccBonusUnit)
                    node.prevs.indices.forEach{(index: Int) in
                        let newValue = ccValue + ccBonus + node.values[index]
                        //追加すべきindexを取得する
                        let lastindex = (nextnode.prevs.lastIndex(where: {$0.totalValue>=newValue}) ?? -1) + 1
                        if lastindex == N_best{
                            return
                        }
                        let newnode = node.getSqueezedNode(index, value: newValue)
                        nextnode.prevs.insert(newnode, at: lastindex)
                        //カウントがオーバーしている場合は除去する
                        if nextnode.prevs.count > N_best{
                            nextnode.prevs.removeLast()
                        }
                    }
                }
            }

        }
        
        let result = LatticeNode.EOSNode
        addedNodes.indices.forEach{(i: Int) in
            addedNodes[i].forEach{(node: LatticeNode) in
                if node.prevs.isEmpty{
                    return
                }
                //生起確率を取得する。
                let wValue = node.data.value()
                //valuesを更新する
                node.values = node.prevs.map{$0.totalValue + wValue}
                //最後に至るので
                node.prevs.indices.forEach{
                    let newnode = node.getSqueezedNode($0, value: node.values[$0])
                    result.prevs.append(newnode)
                }
            }
        }
        
        let updatedNodes = nodes.indices.map{
            return nodes[$0] + addedNodes[$0]
        }
        return (result: result, nodes: updatedNodes)
    }


}