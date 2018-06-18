//
//  NewFeedsViewController.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 3/20/18.
//  Copyright © 2018 Alanda Syla. All rights reserved.
//

import UIKit
import Firebase

class NewFeedsViewController: UIViewController
{
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    var textViewPlaceholderText = "Add a description!"
    
    var takenImage: UIImage!
    var imagePicker: UIImagePickerController!
    var didShowCamera = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !didShowCamera {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
            } else {
                imagePicker.sourceType = .photoLibrary
            }
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextView.text = textViewPlaceholderText
        captionTextView.textColor = UIColor.lightGray
        captionTextView.delegate = self
        
    }
    
    @IBAction func shareAction()
    {
        if captionTextView.text != textViewPlaceholderText && captionTextView.text != "" && takenImage != nil {
            let newPost = PostImages(image: self.takenImage, caption: self.captionTextView.text)
            newPost.savePost()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelDidTap(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}


extension NewFeedsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(image)
        
        self.takenImage = image
        self.postImageView.image = takenImage
        didShowCamera = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewFeedsViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholderText {
            textView.text = ""
            textView.textColor = .lightGray
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}



