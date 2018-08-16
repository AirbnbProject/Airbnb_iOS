//
//  ReviewListCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 9..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class ReviewListCell: UICollectionViewCell {

    @IBOutlet weak var reviewMent: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var reviewProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewProfile.layer.cornerRadius = self.reviewProfile.frame.width / 2
        reviewProfile.layer.masksToBounds = true
    }

}
