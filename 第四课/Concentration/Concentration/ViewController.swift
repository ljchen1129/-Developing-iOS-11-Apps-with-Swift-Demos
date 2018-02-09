//
//  ViewController.swift
//  Concentration
//
//  Created by 陈良静 on 2018/2/8.
//  Copyright © 2018年 陈良静. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 初始化游戏
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // 多少对卡片
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            filpCountLabel.text = "Flip: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var filpCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiChoices = ["🐭","🦊","🐼","🐔", "🦇","🐴","🐑","🌳"]
    private var emoji = [Int: String]()
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
//            更新View
            updateViewFromModel()
        } else {
            print("sender is not in cardButtons")
        }
    }

}

extension ViewController {
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
         }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }

        return emoji[card.identifier] ?? "?"
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
