//
//  PodCollectionCell.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 2/8/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation
import UIKit


class PodCollectionCell: UICollectionViewCell {
    
    @IBOutlet var userLabel: UILabel!
    
    func displayContent(name: String) {
        userLabel.text = name.uppercased()
    }
    
}
