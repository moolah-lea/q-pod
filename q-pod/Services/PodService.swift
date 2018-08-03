//
//  PodService.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 30/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

struct PodService {
    
    static func create(forPod newPod: Pod) {
        // create new pod in database
        
        // 1
        let currentUser = User.current
        // 2
        let pod = newPod
        
        // 4 - Reference to all pods by id
        let podRef = Database.database().reference().child("pods").childByAutoId()
        let key = podRef.key
        
        //set key of the childByAutoId as the podId
        pod.podId = key
        let dict = pod.dictValue
        
        //reference to the pods a user has
        //let podUserRef = Database.database().reference().child("pods/users/").child(currentUser.uid).child(key)
    
        //add this podId to User's list of pods
        UserService.createPod(forCurrUser: key)
        
        //5
        podRef.updateChildValues(dict)
        
    }
    
}
