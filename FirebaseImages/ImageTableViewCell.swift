//
//  ImageTableViewCell.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 3/20/18.
//  Copyright © 2018 Alanda Syla. All rights reserved.
//


import UIKit
import Firebase

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var shadowBackgroundView: UIView!
    
    var post: PostImages! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        // Set background view
        shadowBackgroundView.layer.shadowPath = UIBezierPath(rect: shadowBackgroundView.bounds).cgPath
        shadowBackgroundView.layer.shadowColor = UIColor.black.cgColor
        shadowBackgroundView.layer.shadowOpacity = 0.1
        shadowBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowBackgroundView.layer.shadowRadius = 2
        shadowBackgroundView.layer.masksToBounds = false
        shadowBackgroundView.layer.cornerRadius = 3.0
        
        // caption
        self.captionLabel.text = post.caption
        
        // image
        if let imageDownloadURL = post.downloadURL {
            let imageStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
            imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { [weak self] (data, error) in
                if let error = error {
                    print("Error \(error)")
                } else {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self?.postImageView.image = image
                        }
                    }
                }
            }
        }
        
    }
}
