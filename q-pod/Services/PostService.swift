//
//  PostService.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 1/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    
    static func create(for image: UIImage, completion: @escaping (URL?) -> Void) {
        let imageRef = StorageReference.newPostImageReference()
        //var urlString:

        StorageService.uploadImage(image, at: imageRef) { (url) in
            guard let downloadURL = url else {
                return
            }
            let urlString = downloadURL.absoluteString
            print(urlString)
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
            completion(downloadURL)
        }

    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        // create new post in database
        
        // 1
        let currentUser = User.current
        // 2
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        // 3
        let dict = post.dictValue
        
        // 4
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        //5
        postRef.updateChildValues(dict)
    }
    
}
