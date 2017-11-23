//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 23.11.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var caption: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
