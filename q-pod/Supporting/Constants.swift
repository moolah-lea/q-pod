//
//  Constants.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
        static let toCreatePod = "toCreatePod"
        static let setUserLocation = "setUserLocation"
        static let goToPod = "goToPod"
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
    
    struct Icons {
        static let addLocation = "ic_add_location.png"
        static let logo = "nav_logo_dark.png"
    }
    
}
