//
//  SignupViewController.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 26/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit
import CoreData

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
        if textFieldName.text == nil{
            return
        }else if textFieldEmail.text == nil{
            return
        }else if textFieldPassword.text == nil{
            return
        }
        let appDelegate  = UIApplication.shared.delegate as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext{
            let entity = Users(context: context)
            entity.email = textFieldEmail.text
            entity.password = textFieldPassword.text
            entity.name = textFieldName.text
            
            do {
                try context.save()
                self.navigationController?.popViewController(animated: true)
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
}
