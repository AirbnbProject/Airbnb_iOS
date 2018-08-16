//
//  ReviewCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {

    @IBOutlet weak var reviewGrade: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var reviewMent: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewImageView.layer.cornerRadius = self.reviewImageView.frame.width / 2
        reviewImageView.layer.masksToBounds = true
    }

}
