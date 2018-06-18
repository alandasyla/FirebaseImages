//
//  SignInViewController.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 3/20/18.
//  Copyright © 2018 Alanda Syla. All rights reserved.
//

import UIKit
import Firebase
class SignInViewController: UIViewController
{

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var paswordTxt: UITextField!
    
    
     // MARK : Action Login
    
    @IBAction func loginAction(_ sender: Any)
    {

        if let email = emailTxt.text, let password = paswordTxt.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: NewsFeedsTableViewController = storyboard.instantiateViewController(withIdentifier: "NewsfeedTableViewController") as! NewsFeedsTableViewController
                let navBar = UINavigationController(rootViewController: vc)
                self.present(navBar, animated: true, completion: nil)
            })
        }

    }
    
    // MARK : Action SignUp
    
    @IBAction func SignInAction(_ sender: Any) {
        
        if let email = emailTxt.text, let password = paswordTxt.text {
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                if let firebaseError = error {
                    print (firebaseError.localizedDescription)
                    return
                }
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: NewsFeedsTableViewController = storyboard.instantiateViewController(withIdentifier: "NewsfeedTableViewController") as! NewsFeedsTableViewController
                let navBar = UINavigationController(rootViewController: vc)
                self.present(navBar, animated: true, completion: nil)

            })
        }

    }
}
