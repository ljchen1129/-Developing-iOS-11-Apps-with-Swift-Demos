//
//  ViewController.swift
//  Concentration
//
//  Created by 陈良静 on 2018/2/8.
//  Copyright © 2018年 陈良静. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount: Int = 0
    
    @IBAction func touchCard(_ sender: UIButton) {
        filpCard(withEmoji: "👻", on: sender)
    }
    
    func filpCard(withEmoji emoji:String, on button:UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    

}

