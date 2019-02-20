//
//  TweetViewController.swift
//  Twitter
//
//  Created by Myron on 2/17/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.becomeFirstResponder()
        //enables keyboard 

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tweetView: UITextView!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tweetButton(_ sender: Any) {
        if (!tweetView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetView.text, success: {
                print("successfully posted")
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else{
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
