//
//  ProfileTextFieldCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class ProfileTextFieldCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detailInfo: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
