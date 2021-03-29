//
//  NumberFlippingView.swift
//  Ticked
//
//  Created by Vincent Coetzee on 2018/08/09.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import UIKit

class DigitView: UIView
    {
    private var digitLayer = CenteredTextLayer()
    private var font = UIFont(name:"SFProText-Heavy",size:300)!
    
    public var textColor:UIColor = .tickedNeonOrange
        {
        didSet
            {
            self.digitLayer.textColor = self.textColor
            }
        }
        
    public var digit:String = "0"
        {
        didSet(oldValue)
            {
            if oldValue != digit
                {
                self.update()
                }
            }
        }
    
    public override func awakeFromNib()
        {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.backgroundColor = .black
        self.digitLayer = makeDigitLayer(digit)
        self.layer.addSublayer(digitLayer)
        self.digitLayer.frame = self.bounds
        self.digitLayer.update()
        self.layer.borderWidth = 20
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
        }
    
    public override func layoutSubviews()
        {
        super.layoutSubviews()
        self.digitLayer.frame = self.bounds
        }
    
    private func update()
        {
        let newLayer = makeDigitLayer(digit)
        var theseBounds = self.bounds
        theseBounds.origin.y += theseBounds.height
        newLayer.frame = theseBounds
        newLayer.update()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.layer.addSublayer(newLayer)
        CATransaction.setCompletionBlock
            {
            self.digitLayer.textColor = .black
            self.digitLayer.removeFromSuperlayer()
            self.digitLayer = newLayer
            }
        let topAnimation = CABasicAnimation(keyPath: "position.y")
        topAnimation.fromValue = self.digitLayer.position.y
        topAnimation.toValue = self.digitLayer.position.y - theseBounds.height
        topAnimation.duration = 0.7
        self.digitLayer.add(topAnimation, forKey: nil)
        self.digitLayer.position = self.digitLayer.position - CGPoint(x:0,y:theseBounds.height)
        let bottomAnimation = CABasicAnimation(keyPath: "position.y")
        bottomAnimation.fromValue = newLayer.position.y
        bottomAnimation.toValue = newLayer.position.y - theseBounds.height
        bottomAnimation.duration = 0.7
        newLayer.add(bottomAnimation, forKey: nil)
        newLayer.position = newLayer.position - CGPoint(x:0,y:theseBounds.height)
        CATransaction.commit()
        }
    
    private func makeDigitLayer(_ digit:String) -> CenteredTextLayer
        {
        let textLayer = CenteredTextLayer()
        textLayer.textColor = self.textColor
        textLayer.font = font
        textLayer.text = digit
        textLayer.update()
        return(textLayer)
        }
    }
