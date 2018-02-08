//
//  ViewController.swift
//  Concentration
//
//  Created by 陈良静 on 2018/2/8.
//  Copyright © 2018年 陈良静. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet {
            filpCountLabel.text = "Flip: \(flipCount)"
        }
    }
    
    @IBOutlet weak var filpCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices:Array<String> = ["🐭","🦊","🐼","🐔"]
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("sender is not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji:String, on button:UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    

}

