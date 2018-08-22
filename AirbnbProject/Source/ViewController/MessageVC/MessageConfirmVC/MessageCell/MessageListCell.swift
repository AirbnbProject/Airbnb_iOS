//
//  MessageListCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 17..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class MessageListCell: UITableViewCell {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageDate: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInitialize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupInitialize() {
        profile.layer.cornerRadius = self.profile.frame.width / 2
        profile.layer.masksToBounds = true
    }
    
    

}
