//
//  ViewController.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 26/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//MARK:-  IBAction Methods
    @IBAction func btnLogin(_ sender: Any?){
        guard let email = textFieldEmail.text else { return }
        guard let password = textFieldPassword.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (auth, err) in
            if err != nil{
                print(err?.localizedDescription)
            }else{
                
                guard let uid = auth?.user.uid else {
                    return
                }
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: DataEventType.value, with: { (snapShot) in
                    let allMembersController = self.storyboard?.instantiateViewController(withIdentifier: "AllMemmbersTableViewController") as! AllMemmbersTableViewController
                    let dict = snapShot.value as? [String: String]
                    allMembersController.navigationItem.title = dict?["name"]
                    self.navigationController?.pushViewController(allMembersController, animated: true)
                })
            }
        }
    }    
}

