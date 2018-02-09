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
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard:Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
//                没有卡片是正面或者两个卡片都是正面，
                for flipDowmIndex in cards.indices {
                    cards[flipDowmIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
      
    }
}
