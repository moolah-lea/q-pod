//
//  UIColor+Icons.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 13/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

extension UIColor {
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
