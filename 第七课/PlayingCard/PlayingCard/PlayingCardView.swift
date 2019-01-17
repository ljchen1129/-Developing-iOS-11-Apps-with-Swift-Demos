//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by 陈良静 on 2019/1/16.
//  Copyright © 2019 xxx. All rights reserved.
//

import UIKit

// 将代码的设置显示到IB监视器中去
@IBDesignable
// 扑克牌视图
class PlayingCardView: UIView {
    
    @IBInspectable // 将属性显示到IB监视器中去设置
    var rank: Int = 11 { didSet { setNeedsDisplay(); setNeedsLayout() }}
    @IBInspectable
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() }}
    @IBInspectable
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() }}
    
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // 通过pitch缩放手势调整图片的缩放参数
    @objc func adjustFaceCardScale(byHandlingGestureRecongnizedBy recongizer: UIPinchGestureRecognizer) {
        switch recongizer.state {
            case .changed, .ended:
                faceCardScale *= recongizer.scale
                // 重置缩放手势的scale
                recongizer.scale = 1.0
            default: break
        }
    }
    
    // 扑克牌左上、右下标题
    private func centerdAttributedString (_ string: String, fontSize:CGFloat) -> NSAttributedString  {
        // 字体
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        
        // 设置字体跟随系统设置字体变化
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        // 设置段落对齐方式
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, .font: font])
    }
    
    // 扑克牌左上、右下标题文本
    private var cornerString : NSAttributedString {
        return centerdAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
    }
    
    // 扑克牌左上、右下标题lable
    private lazy var upperLeftCornerlable = creatCornerLable()
    private lazy var lowerRightConerLable = creatCornerLable()
    
    // 创建扑克牌左上、右下标题lable
    private func creatCornerLable() -> UILabel {
        let lable = UILabel()
        lable.numberOfLines = 0
        addSubview(lable)
        return lable
    }
    
    // 设置扑克牌左上、右下标题lable
    private func configreCornerLable(_ lable: UILabel) {
        lable.attributedText = cornerString
        lable.frame.size = CGSize.zero
        lable.sizeToFit()
        lable.isHidden = !isFaceUp
    }
    
    // 扑克牌不是Jack、Q、King 时，使用文本排列画上去
    private func drawPips()
    {
        let pipsPerRowForRank = [[0], [1], [1,1], [1,1,1], [2,2], [2,1,2], [2,2,2], [2,1,2,2], [2,2,2,2], [2,2,1,2,2], [2,2,2,2,2]]
        
        func createPipString(thatFits pipRect: CGRect) -> NSAttributedString {
            let maxVerticalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.count, $0)})
            let maxHorizontalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.max() ?? 0, $0)})
            let verticalPipRowSpacing = pipRect.size.height / maxVerticalPipCount
            
            let attemptedPipString = centerdAttributedString(suit, fontSize: verticalPipRowSpacing)
            let probablyOkayPipStringFontSize = verticalPipRowSpacing / (attemptedPipString.size().height / verticalPipRowSpacing)
            let probablyOkayPipString = centerdAttributedString(suit, fontSize: probablyOkayPipStringFontSize)
            if probablyOkayPipString.size().width > pipRect.size.width / maxHorizontalPipCount {
                return centerdAttributedString(suit, fontSize: probablyOkayPipStringFontSize /
                    (probablyOkayPipString.size().width / (pipRect.size.width / maxHorizontalPipCount)))
            } else {
                return probablyOkayPipString
            }
        }
        
        if pipsPerRowForRank.indices.contains(rank) {
            let pipsPerRow = pipsPerRowForRank[rank]
            var pipRect = bounds.insetBy(dx: cornerOffset, dy: cornerOffset).insetBy(dx: cornerString.size().width, dy: cornerString.size().height / 2)
            let pipString = createPipString(thatFits: pipRect)
            let pipRowSpacing = pipRect.size.height / CGFloat(pipsPerRow.count)
            pipRect.size.height = pipString.size().height
            pipRect.origin.y += (pipRowSpacing - pipRect.size.height) / 2
            for pipCount in pipsPerRow {
                switch pipCount {
                case 1:
                    pipString.draw(in: pipRect)
                case 2:
                    pipString.draw(in: pipRect.leftHalf)
                    pipString.draw(in: pipRect.rightHalf)
                default:
                    break
                }
                pipRect.origin.y += pipRowSpacing
            }
        }
    }
    
    // 系统方法，当
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }

    // 重新布局子视图时调用
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configreCornerLable(upperLeftCornerlable)
        upperLeftCornerlable.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configreCornerLable(lowerRightConerLable)
        lowerRightConerLable.transform = CGAffineTransform.identity.translatedBy(x: lowerRightConerLable.frame.size.width, y: lowerRightConerLable.frame.size.height).rotated(by: CGFloat.pi)
        lowerRightConerLable.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset).offsetBy(dx: -lowerRightConerLable.frame.size.width, dy: -lowerRightConerLable.frame.size.height)
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // 1. 使用图形上下文绘制一个圆形
//        if let context = UIGraphicsGetCurrentContext() {
//            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi , clockwise: true)
//            context.setLineWidth(5.0)
//            UIColor.red.setFill()
//            UIColor.green.setStroke()
//            context.strokePath()
//            context.fillPath()
//
//        }
        
        // 2. 使用贝塞尔曲线绘制一个圆
        let path = UIBezierPath()
        path.addArc(withCenter:  CGPoint(x: bounds.midX, y: bounds.midY), radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi , clockwise: true)
        path.lineWidth = 5.0
        UIColor.red.setFill()
        UIColor.green.setStroke()
        path.stroke()
        path.fill()
        
        
        
        // 带圆角的矩形
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadios)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        // 当扑克牌是正面时
        if isFaceUp {
            if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                faceCardImage.draw(in: bounds.zoom(by: faceCardScale))
            } else {
                drawPips()
            }
        } else {
            if let cardBackImage = UIImage(named: "cardback") {
                cardBackImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
            }

        }
    }

}


extension PlayingCardView {
    
    // 一些比例系数
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiosToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadios: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadios: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiosToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadios * SizeRatio.cornerOffsetToCornerRadios
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        switch rank {
            case 1: return "A"
            case 2...10: return String(rank)
            case 11: return "J"
            case 12: return "Q"
            case 13: return "K"
            default: return "?"
        }
    }
}


extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
    
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
