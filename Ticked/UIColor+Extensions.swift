//
//  UIColor+Extensions.swift
//  Ticked
//
//  Created by Vincent Coetzee on 3/23/21.
//  Copyright © 2021 Vincent Coetzee. All rights reserved.
//

import UIKit

extension UIColor
    {
    public static let tickedMangoGreen:UIColor = UIColor(hex: 0x96ff00)
    public static let tickedSeaGreen:UIColor = UIColor(hex: 0x007563)
    public static let tickedNeonYellow:UIColor = UIColor(hex: 0xF3F315)
    public static let tickedNeonOrange = UIColor(red: 237.0/255.0,green: 111.0/255.0,blue:45.0/255.0,alpha:1)
    public static let tickedNeonGreen = UIColor(red: 128.0/255.0,green: 189.0/255.0,blue:4.0/255.0,alpha:1)
    public static let tickedPlainPink = UIColor(red: 255.0/255.0,green: 0.0/255.0,blue:123.0/255.0,alpha:1)
    public static let tickedNeonFuchsia:UIColor = UIColor(hex: 0xfe4164)
    public static let tickedNeonPink = UIColor(red: 255.0/255.0,green: 0/255.0,blue:153.0/255.0,alpha:1)
    public static let tickedNeonRed:UIColor = UIColor(hex: 0xff3855)
        
    public var valueArray:Array<CGFloat>
        {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        self.getRed(&red, green: &green , blue: &blue, alpha: &alpha)
        return([red,green,blue,alpha])
        }
        
    convenience init(valueArray:Array<CGFloat>)
        {
        let red = valueArray[0]
        let green = valueArray[1]
        let blue = valueArray[2]
        let alpha = valueArray[3]
        self.init(red: red,green:green,blue:blue,alpha:alpha)
        }
        
    convenience init(hex:Int)
        {
        print(hex)
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        self.init(red: CGFloat(red)/255.0,green: CGFloat(green)/255.0,blue:CGFloat(blue)/255.0,alpha: 1.0)
        }
        
    public func imageInColor(ofSize:CGSize) -> UIImage
        {
        UIGraphicsBeginImageContext(ofSize)
        let context = UIGraphicsGetCurrentContext()
        self.set()
        context?.addRect(CGRect(origin:.zero,size:ofSize))
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return(image!)
        }
    }
