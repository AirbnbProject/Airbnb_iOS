//
//  PopularTrip.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class PopularTrip: UICollectionViewCell {

    @IBOutlet weak var tripGrade: UILabel!
    @IBOutlet weak var tripPrice: UILabel!
    @IBOutlet weak var tripName: UILabel!
    @IBOutlet weak var tripInfo: UILabel!
    @IBOutlet weak var tripImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
