//
//  CaptureViewController.swift
//  Postagram
//
//  Created by Sheng Liu on 3/17/19.
//  Copyright © 2019 Sheng Liu. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
       
        let imageData = imageView.image!.pngData()
        
        let file = PFFileObject(data: imageData!) // creating a binary object from an image
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else{
                print("error \(error)")
            }
        }
    }

    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController() // special build in controller
        
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        
        let scaleImage = image.af_imageScaled(to: size)
        
        imageView.image = scaleImage
        dismiss(animated: true, completion: nil)
        
    }
}
