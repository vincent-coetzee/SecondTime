//
//  NumberFlippingView.swift
//  Ticked
//
//  Created by Vincent Coetzee on 2018/08/09.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import UIKit

class DigitFlippingView: UIView
    {
    public var digit:Digit = Digit(0)
        {
        didSet
            {
            update()
            }
        }
    
    private func update()
        {
        let layer = makeDigitLayer()
        }
    
    private func makeDigitLayer() -> CALayer
        {
        let textLayer = CenteredTextLayer()
        textLayer.borderWidth = 20
        textLayer.borderColor = UIColor.white.cgColor
        textLayer.cornerRadius = 10
        }
    }
