//
//  Pod.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 13/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation
import MapKit

class Pod {
    
    //properties and initializers
    let podId: String?
    let ownerId: String?
    let passcode: String?
    var participantsId: [String]
    var whatVal: String?
    var whenVal: Date?
    var whereVal: String?
    var locPlaceMark: MKPlacemark?
    var podImgUrl: String?
    var podUrl: String?
    var doc: Date?
    var willExpire: Bool = true
    
    init(){
        podId = ""
        ownerId = ""
        passcode = ""
        participantsId = []
        whatVal = ""
        whenVal = Date()
        whereVal = ""
        locPlaceMark = nil
        podImgUrl = ""
        podUrl = ""
        doc = Date()
        willExpire = true
    }
    
    init(ownerId: String) {
        self.ownerId = ownerId
        
        //create a unique ID for podId
        podId = "pod\(UUID().uuidString)"
        
        //generate a random dictionary word with numbers for passcode
        passcode = PassGenerator().randomPassCode()
        
        //create an empty array of participants ID
        participantsId = []
        
        //fill in values of what/where/when
        whatVal = ""
        whenVal = Date()
        whereVal = ""
        locPlaceMark = nil
        
        //get imgurl
        
        
        //get podUrl via implementing Dynamic Links
        
        
        //date of creation should be current date
        doc = Date()
        
        
    }
    
    
    
    
    
}
