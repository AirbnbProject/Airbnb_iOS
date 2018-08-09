//
//  TwoLineHeaderCollectionReusableView.swift
//  AirbnbProject
//
//  Created by 박인수 on 31/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class TwoLineHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var twoLineHeaderTitle: UILabel!
    @IBOutlet weak var twoLineHeaderSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        twoLineHeaderTitle.text = "TwoLineHeaderTitle"
        twoLineHeaderSubtitle.text = "TwoLineHeaderSubTitle"
    }
    
}
