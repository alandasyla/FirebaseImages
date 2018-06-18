//
//  SignInTableViewController.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 6/17/18.
//  Copyright © 2018 Duc Tran. All rights reserved.
//

import UIKit
import Firebase

class SignInTableViewController: UITableViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var paswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
