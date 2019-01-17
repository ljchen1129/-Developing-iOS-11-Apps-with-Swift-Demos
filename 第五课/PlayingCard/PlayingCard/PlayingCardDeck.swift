//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by 陈良静 on 2019/1/16.
//  Copyright © 2019 xxx. All rights reserved.
//

import Foundation

// 一副扑克牌
struct PlayingCardDeck
{
    
    private(set) var cards = [PlayingCard]()
    
    // 初始化一副扑克牌
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard.init(suit: suit, rank: rank))
            }
        }
    }
    
    // 从一副扑克牌中随机抽出一张
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random:Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if (self < 0) {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
    
}
