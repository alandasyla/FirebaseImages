//
//  NewsFeedsTableViewController.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 3/20/18.
//  Copyright © 2018 Alanda Syla. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class NewsFeedsTableViewController: UITableViewController {
    
    var posts = [PostImages]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // download posts
        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
            // snapshot is now a dictionary
            let newPost = PostImages(snapshot: snapshot)
            DispatchQueue.main.async {
                self.posts.insert(newPost, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .top)
            }
        }
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        
        showActinSheet()
    }
    
    // MARK : SignOut func
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
            
        }
        
        let st = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = st.instantiateViewController(withIdentifier: "SignInTableViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    // MARK : Show Action Sheet
    
    func showActinSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOut = UIAlertAction(title: "Sign Out", style: .default) { (_) in
            self.signOut()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(signOut)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! ImageTableViewCell
        let post = self.posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }
}


