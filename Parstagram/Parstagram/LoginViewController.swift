//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Myron on 2/21/19.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignin(_ sender: Any) {
        let user = PFUser()
        let username = UsernameField.text!
        let password = PasswordFeild.text!
        //assigning input feild into var.
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else {
                print ("Error: \(error?.localizedDescription)")
            }
            
        }
        //If user info isn't = to null than log in if not return error
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = UsernameField.text
        user.password = PasswordFeild.text
        
        user.signUpInBackground{(success, error )in
        if success{
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        } else{
            print("Error: \(error?.localizedDescription)")
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
}
