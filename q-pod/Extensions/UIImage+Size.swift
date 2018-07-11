//
//  UIImage+Size.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 11/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
