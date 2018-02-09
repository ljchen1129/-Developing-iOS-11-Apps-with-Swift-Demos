//
//  Concentration.swift
//  Concentration
//
//  Created by 陈良静 on 2018/2/8.
//  Copyright © 2018年 陈良静. All rights reserved.
//

import Foundation

// 类
class Concentration
{
    private(set) var cards = [Card]()
    
    // 正面朝上卡片的索引
    private var indexOfOneAndOnlyFaceUpCard:Int? {
        get {
            var foundIndex:Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
    
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
            } else {
//                没有卡片是正面或者两个卡片都是正面
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(): you must have at least pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        for i in stride(from:0.5, to:15.5, by:0.3) {
            print(i)
        }
        
    }
}
