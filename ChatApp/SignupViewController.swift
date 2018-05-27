//
//  SignupViewController.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 26/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageViewProfile.isUserInteractionEnabled = true
        self.imageViewProfile.contentMode = .scaleAspectFill
        self.imageViewProfile.clipsToBounds = true
        self.imageViewProfile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImageViewController)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK:-  Private Functions
    @objc private func openImageViewController(){
        let imageController = UIImagePickerController()
        imageController.allowsEditing = false
        imageController.sourceType = .photoLibrary
        imageController.delegate = self
        self.present(imageController, animated: true, completion: nil)
    }
    
//MARK:-  UIImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        self.imageViewProfile.image = image as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
//MARK:-   IBAction Methods
    
    @IBAction func btnSignUp(_ sender: Any?){
        
        guard let name = textFieldName.text else { return }

        guard let email = textFieldEmail.text else { return }
        
        guard let password = textFieldPassword.text else { return }

        self.view.isUserInteractionEnabled = false
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            guard let uid = auth?.user.uid else {
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://chat-50cdf.firebaseio.com/")
            let values = ["name":name, "email":email]
            let userRef = ref.child("users").child(uid)
            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil{
                    print(err?.localizedDescription)
                    return
                }
                self.view.isUserInteractionEnabled = true
                self.navigationController?.popViewController(animated: true)
                print("DataSaved successfully.")
            })
        }
    }
}
