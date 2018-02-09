//
//  Card.swift
//  Concentration
//
//  Created by 陈良静 on 2018/2/9.
//  Copyright © 2018年 陈良静. All rights reserved.
//

import Foundation

// 结构体
struct Card
{
    var  isFaceUp = false
    var  isMatched = false
    var  identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier()->Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

