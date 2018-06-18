//
//  PostImages.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 3/20/18.
//  Copyright © 2018 Alanda Syla. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class PostImages {
    private var image: UIImage!
    var caption: String!
    var downloadURL: String?
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    }
    
    init(snapshot: DataSnapshot) {
        let json = JSON(snapshot.value)
        self.caption = json["caption"].stringValue
        self.downloadURL = json["imageDownloadURL"].string
    }
    
    func savePost() {
        let newPostRef = Database.database().reference().child("posts").childByAutoId()
        let newPostKey = newPostRef.key
        
        if let imageData = UIImageJPEGRepresentation(image, 0.5) {
            let storage = Storage.storage().reference().child("images/\(newPostKey)")
            
            storage.putData(imageData).observe(.success, handler: { (snapshot) in
                self.downloadURL = snapshot.metadata?.downloadURL()?.absoluteString
                let postDictionary = [
                    "imageDownloadURL" : self.downloadURL,
                    "caption" : self.caption
                ]
                newPostRef.setValue(postDictionary)
            })
        }
    }
}
