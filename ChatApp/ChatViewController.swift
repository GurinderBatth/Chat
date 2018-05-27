//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 27/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textFieldMessage: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//MARK:-  UITableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessageCell") as! ChatTableViewCell
        
        return cell
        
    }
    
    
//MARK:-  IBAction Methods
    @IBAction func btnSend(_ sender: Any){
    
        guard let message = textFieldMessage.text else { return }
        let ref = Database.database().reference().child("Mesages")
        let childRef = ref.childByAutoId()
        let values = ["text": message,"name":"Gurinder"] as [String : Any]
        childRef.updateChildValues(values)
        
    }
    
}
