//
//  AllMemmbersTableViewController.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 27/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit
import Firebase

class AllMemmbersTableViewController: UITableViewController {

    
    var users = [AllMembers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Database.database().reference().child("users").observe(.childAdded) { (snapShot) in
            
            if let dictionary = snapShot.value as? [String: Any]{
                print(dictionary)
                let user = AllMembers()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.id = snapShot.key
                print(user.id)
                self.users.append(user)
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllMembersCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].email
        return cell
    }
//MARK:- UITableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatController.member = users[indexPath.row]
        self.navigationController?.pushViewController(chatController, animated: true)
    }

}
