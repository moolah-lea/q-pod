//
//  User.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User : NSObject {
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    //failable initializer to return nil if no UID exists
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
    }
    
    //Creating a singleton User object
    // 1
    private static var _current: User?
    
    // 2
    static var current: User {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 5
    
    //1
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            // 4
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }

    /*******************************************************
     1. We add another parameter that takes a Bool on whether the user should be written to UserDefaults. We give this value a default value of false.
     2. We check if the boolean value for writeToUserDefaults is true. If so, we write the user object to UserDefaults.
     3. We use NSKeyedArchiver to turn our user object into Data. We needed to implement the NSCoding protocol and inherit from NSObject to use NSKeyedArchiver.
     4. We store the data for our current user with the correct key in UserDefaults.
    *******************************************************/
    
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}

