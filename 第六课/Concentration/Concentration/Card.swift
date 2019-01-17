//
//  Card.swift
//  Concentration
//
//  Created by 陈良静 on 2018/2/9.
//  Copyright © 2018年 陈良静. All rights reserved.
//

import Foundation

// 结构体
struct Card : Hashable
{
    var  isFaceUp = false
    var  isMatched = false
    private  var  identifier: Int
    private static var identifierFactory = 0
    
    var hashValue : Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
            return lhs.identifier == rhs.identifier
    }
    
    private static func getUniqueIdentifier()->Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}





