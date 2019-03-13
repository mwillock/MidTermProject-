//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Myron on 2/21/19.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    var posts = [PFObject]()
    var selectedPost: PFObject!    // optional

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        //return true
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Post")
        //query.includeKey("author")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.order(byDescending: "createdAt")
        
        /* added above from discussion post:https://discussions.codepath.com/courses/ios_university/questions/new-picture-at-the-bottom */
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")
        
        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            } // else
        }  // post.saveInBackground
        
        
        tableView.reloadData()
        
        // Clear and dismiss the input bar
        commentBar.inputTextView.text = nil
        
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count + 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section] // use to grab certain post
        let comments = (post["comments"] as? [PFObject]) ?? []

        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let user = post["author"] as! PFUser
            cell.usernameLabel.text = user.username
        
            cell.captionLabel.text = post["caption"] as? String
        
            let imageFile = post["image"] as! PFFileObject //Pull url
            let urlString = imageFile.url! //optioncal String
            let url = URL(string: urlString) //create url
        
            cell.photoView.af_setImage(withURL: url!)
        
            return cell
        } else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            let comment = comments[indexPath.row - 1]
            cell.CommentPost.text = comment["text"] as? String
            
            let user = comment["author"] as! PFUser
            cell.CommentAurth.text = user.username
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
            }
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "loginViewController")
        
       let delegate = UIApplication.shared.delegate as! AppDelegate // the sub class has access so create a reference
        
        delegate.window?.rootViewController = loginViewController
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let post = posts[indexPath.row]  DONT DO THIS
        let post = posts[indexPath.section]   // DO THIS INSTEAD
        //let comment = PFObject(className: "Comments")
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }
        /*let post = posts[indexPath.row] // selecting the row
        
        let comment = PFObject(className: "Comments")
        comment["text"] = " this is a random comment"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        
        post.add(comment, forKey: "comments")
        post.saveInBackground{ (success, error) in
            if success{
                print("Comment saved")
            }else {
                print("Error saving comment") */
            }

}
