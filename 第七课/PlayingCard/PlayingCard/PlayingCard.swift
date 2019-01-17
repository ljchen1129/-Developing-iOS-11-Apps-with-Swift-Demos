//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by 陈良静 on 2019/1/16.
//  Copyright © 2019 xxx. All rights reserved.
//

import Foundation

// 定义一张扑克牌的数据结构
struct PlayingCard
{
    // 花色
    var suit: Suit
    // 大小
    var rank: Rank
    
    enum Suit: String {
        case spades     = "♠️"
        case hearts     = "♥️"
        case clubs      = "♣️"
        case diamonds   = "♦️"
        
        static var all = [Suit.spades, .hearts, .clubs, .diamonds]
    }
    
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric(let pips): return pips
                case .face(let kind) where kind == "J" : return 11
                case .face(let kind) where kind == "Q" : return 12
                case .face(let kind) where kind == "K" : return 13
                default : return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
    
            allRanks += [Rank.face("J"), Rank.face("Q"), Rank.face("K")]
            return allRanks
        }
    }

}
