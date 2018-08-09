//
//  DefaultOneLineCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 3..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class DefaultOneLineCell: UITableViewCell {

    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
