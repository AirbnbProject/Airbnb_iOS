//
//  OneLineFooterCollectionReusableView.swift
//  AirbnbProject
//
//  Created by 박인수 on 01/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class OneLineFooterCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var oneLineFooterBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        oneLineFooterBtn.layer.borderWidth = 0.2
        // oneLineFooterBtn.layer.borderColor = (Insert AirBnb Color)
        oneLineFooterBtn.layer.cornerRadius = 5.0
        oneLineFooterBtn.layer.masksToBounds = true
        
        
    }
    
}
