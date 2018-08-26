//
//  ProfileUpdateCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 3..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

protocol ProfileUpdateCellDelegate: class {
    func profileImageDidSelect(profileImage: UIImage?)
}

class ProfileUpdateCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    weak var delegate: ProfileUpdateCellDelegate?
    
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
    
    @IBAction func profileConfirm(_ sender: UIButton) {
        print("profile Select")
        
        delegate?.profileImageDidSelect(profileImage: nil)
    }
    

}
