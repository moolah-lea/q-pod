//
//  StorageService.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 1/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit
import FirebaseStorage

struct StorageService {
    // provide method for uploading images

    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        
        // 1
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        // 2
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }

            reference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                print("DOWNLOAD URL: \(downloadURL.absoluteString)")
                completion(downloadURL)
            }
            
        })
    }
}
    



/***********************************************************************
 1. First we change the image from an UIImage to Data and reduce the quality of the image. It is important to reduce the quality of the image because otherwise the images will take a long time to upload and download from Firebase Storage. If we can't convert the image into Data, we return nil to the completion callback to signal something went wrong.
 2. We upload our media data to the path provided as a parameter to the method.
 3. After the upload completes, we check if there was an error. If there is an error, we return nil to our completion closure to signal there was an error. Our assertFailure will crash the app and print the error when we're running in debug mode.
 4. If everything was successful, we return the download URL for the image.
 
***********************************************************************/

