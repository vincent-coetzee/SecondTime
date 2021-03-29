//
//  CenteredTextLayer.swift
//  LayerKit
//
//  Created by Vincent Coetzee on 2018/08/09.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import UIKit

public class CenteredTextLayer:CALayer
    {
    public var font:UIFont = UIFont.boldSystemFont(ofSize: 10)
        {
        didSet
            {
            self.layout()
            }
        }
    
    public var text:String?
        {
        didSet
            {
            self.layout()
            }
        }
    
    public var textColor:UIColor = .black
        {
        didSet
            {
            self.textLayer.foregroundColor = self.textColor.cgColor
            }
        }
    
    private var textLayer:CATextLayer = CATextLayer()
    
    override init()
        {
        super.init()
        self.initComponents()
        }
    
    required init?(coder aDecoder: NSCoder)
        {
        super.init(coder:aDecoder)
        self.initComponents()
        }
    
    override init(layer:Any)
        {
        super.init(layer:layer)
        }
    
    private func initComponents()
        {
        addSublayer(textLayer)
        }
    
    public func update()
        {
        self.layout()
        }
    
    private func layout()
        {
        guard let textString = self.text else
            {
            return
            }
        let attributes:[NSAttributedString.Key:Any] = [.font:font,.foregroundColor:textColor]
        let string = NSAttributedString(string: textString,attributes: attributes)
        let size = string.size()
        let theseBounds = self.bounds
        let offsetX = (theseBounds.width - size.width) / 2.0
        let offsetY = (theseBounds.height - size.height) / 2.0
        self.textLayer.string = text
        self.textLayer.font = font.fontName as CFTypeRef
        self.textLayer.fontSize = font.pointSize
        self.textLayer.foregroundColor = textColor.cgColor
        self.textLayer.frame = CGRect(origin: CGPoint(x: offsetX,y:offsetY),size: size)
        }
}
