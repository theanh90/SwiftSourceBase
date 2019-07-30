//
//  UserCell.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 8/1/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell, Identified {
    // MARK: - IBOutlet
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(user: UserModel) {
        emailLabel.text = user.email
        nameLabel.text = user.name
        webLabel.text = user.website
    }

}
