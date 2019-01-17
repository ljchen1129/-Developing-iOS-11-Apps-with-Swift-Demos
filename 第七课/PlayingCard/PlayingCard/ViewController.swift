//
//  ViewController.swift
//  PlayingCard
//
//  Created by 陈良静 on 2019/1/16.
//  Copyright © 2019 xxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 初始化一副扑克牌
    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            
            // 滑动手势
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            // 缩放手势
            let pitch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecongnizedBy:)))
            playingCardView.addGestureRecognizer(pitch)
        }
    }
    
    // 点击手势，翻转扑克牌
    @IBAction func flipCard(_ sender: UIGestureRecognizer) {
        switch sender.state {
            case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
            default: break
        }
    }
    
    // 下一张
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}

