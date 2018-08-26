//
//  HostInfoCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class HostInfoCell: UICollectionViewCell {

    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var hostLocation: UILabel!
    @IBOutlet weak var hostProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hostProfile.layer.cornerRadius = self.hostProfile.frame.width / 2
        hostProfile.layer.masksToBounds = true
    }

}
