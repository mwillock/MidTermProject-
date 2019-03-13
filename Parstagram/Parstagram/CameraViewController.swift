//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Myron on 2/23/19.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //UIImagePickerControllerDelegate- Give you camera events,
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentFeild: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Allowing to create a colum on Parse DB on Submit Button
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Post")
        
        post["caption"] = commentFeild.text!
        post ["author"] = PFUser.current()
        //to store image in DB,
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        post.saveInBackground{ (success,error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("save!")
            }else{
                print("error!")
            }
            
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        //Easier methhod of connection
        picker.delegate = self
        //Calls back to app after recieving image
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    //Returning the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300) //Selecting a graphic size
        let scaledImage = image.af_imageScaled(to: size) //use alamo to scale image down
        
        imageView.image = scaledImage //placing scaled image inside of image
        
        dismiss(animated: true, completion: nil) //dismiss camera view
        
        
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
