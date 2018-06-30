//
//  Storyboard+Utility.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum QPType: String {
        case main
        case login
        case home
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: QPType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: QPType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
    
}
