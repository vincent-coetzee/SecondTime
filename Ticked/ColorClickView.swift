//
//  ColorClickView.swift
//  Ticked
//
//  Created by Vincent Coetzee on 3/24/21.
//  Copyright © 2021 Vincent Coetzee. All rights reserved.
//

import UIKit

@IBDesignable
class ColorClickView: UIView
    {
    private let shapeLayer = CAShapeLayer()
    
    public override func awakeFromNib()
        {
        super.awakeFromNib()
        self.layer.addSublayer(self.shapeLayer)
        self.shapeLayer.frame = self.bounds
        }
        
    @IBInspectable public var selectionColor:UIColor = .tickedNeonOrange
        {
        didSet
            {
            self.updateAppearance()
            }
        }
        
    public override func layoutSubviews()
        {
        super.layoutSubviews()
        self.shapeLayer.frame = self.bounds
        self.shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12).cgPath
        }
        
    public override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)
        {
        super.pressesBegan(presses,with:event)
        for item in presses
            {
            if item.type == .select
                {
                self.fireAction()
                }
            }
        }

    private func updateAppearance()
        {
        self.backgroundColor = .clear
        self.shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12).cgPath
        self.shapeLayer.fillColor = self.selectionColor.cgColor
        self.shapeLayer.lineWidth = 10
        self.shapeLayer.strokeColor = UIColor.black.cgColor
        self.shapeLayer.lineDashPattern = nil
        self.layer.backgroundColor = UIColor.tickedNeonPink.cgColor
        }
        
    public override func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        self.layer.addSublayer(self.shapeLayer)
        self.shapeLayer.frame = self.bounds
        self.selectionColor = .tickedNeonOrange
        self.layer.borderColor = UIColor.tickedNeonOrange.cgColor
        self.layer.borderWidth = 5
        }
        
    public override var canBecomeFocused:Bool
        {
        return(true)
        }
        
    public private(set) var isSelected = false
    public var target:Any?
    public var action:Selector?
    
    private func fireAction()
        {
        if let selector = self.action,let object = self.target as? NSObject
            {
            object.performSelector(onMainThread: selector,with:nil,waitUntilDone:true)
            }
        }
        
    private func startMarchingAnts()
        {
        self.shapeLayer.lineDashPattern = [8,6]
        let animation = CABasicAnimation(keyPath: "lineDashPhase")
        animation.fromValue = 0
        animation.toValue = self.shapeLayer.lineDashPattern?.reduce(0) { $0 - $1.intValue } ?? 0
        animation.duration = 1
        animation.repeatCount = .infinity
        self.shapeLayer.add(animation, forKey: "line")
        }
        
    private func stopMarchingAnts()
        {
        self.shapeLayer.removeAnimation(forKey:"line")
        self.shapeLayer.lineDashPattern = nil
        }
        
    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
        {
        if context.nextFocusedView == self
            {
            coordinator.addCoordinatedAnimations(
                { () -> Void in
                self.shapeLayer.strokeColor = UIColor.white.cgColor
                self.shapeLayer.lineWidth = 4
                self.startMarchingAnts()
                }, completion: nil)
            }
        else if context.previouslyFocusedView == self
            {
            coordinator.addCoordinatedAnimations(
                { () -> Void in
                self.shapeLayer.strokeColor = UIColor.black.cgColor
                self.shapeLayer.lineWidth = 4
                self.stopMarchingAnts()
                }, completion: nil)
            }
        }
    }
