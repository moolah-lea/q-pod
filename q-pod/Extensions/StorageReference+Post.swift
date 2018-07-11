//
//  StorageReference+Post.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 11/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
}
