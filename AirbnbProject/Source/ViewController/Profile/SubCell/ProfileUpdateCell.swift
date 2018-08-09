//
//  ProfileUpdateCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 3..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class ProfileUpdateCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupProfileImage()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupProfileImage() {
        profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
    }

}
