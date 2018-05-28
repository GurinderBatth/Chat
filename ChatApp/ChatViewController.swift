//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 27/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit
import Firebase
import CoreGraphics
import CoreFoundation

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textFieldMessage: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    
    var member : AllMembers?
    
    var messages = [Messages]()
    
    
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = Auth.auth().currentUser?.uid
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeMessages()
    }
    
//MARK:-  UITableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.fromId == userId{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessageCell") as! ChatTableViewCell
            cell.lblMessage.text = message.text
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReciverMessageCell") as! ChatTableViewCell
            cell.lblMessage.text = message.text
            return cell
        }
    }
    
//MARK:-  IBAction Methods
    @IBAction func btnSend(_ sender: Any){
    
        guard let message = textFieldMessage.text else { return }
        let ref = Database.database().reference().child("Messages")
        let childRef = ref.childByAutoId()
        let toID = member?.id
        let fromId = userId
        let timeStamp = Date().timeIntervalSince1970
        let values = ["text": message,"toID":toID!,"fromId": fromId!,"timeStamp":timeStamp] as [String : Any]
        childRef.updateChildValues(values)
        self.textFieldMessage.text = ""
    }
    
//MARK:-  Private Methods
    private func observeMessages(){
        let ref = Database.database().reference().child("Messages")
        ref.observe(.childAdded) { (snapShot) in
            let snapDict = snapShot.value as? [String: Any]
            let message = Messages()
            message.toId = snapDict!["toId"] as? String
            message.fromId = snapDict!["fromId"] as? String
            message.text = snapDict!["text"] as? String
            message.timeStamp = snapDict!["timeStamp"] as? NSNumber
            self.messages.append(message)
            
            self.tableView.reloadData()
        }
    }
    
}
