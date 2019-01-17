//
//  ViewController.swift
//  PlayingCard
//
//  Created by 陈良静 on 2019/1/16.
//  Copyright © 2019 xxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 新建一副扑克牌
        var deck = PlayingCardDeck()
        
        // 随机抽取十张扑克牌
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }
    
    
    
    
    
    
}

