//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Gurinder Singh Batth on 27/5/18.
//  Copyright © 2018 Gurinder Singh Batth. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var imageViewReciveOrSend: UIImageView!
    
    @IBOutlet weak var viewVideo: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
