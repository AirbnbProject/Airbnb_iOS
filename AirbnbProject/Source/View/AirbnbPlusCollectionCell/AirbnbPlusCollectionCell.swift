//
//  FirstCustomCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 30/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class AirbnbPlusCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageview.layer.cornerRadius = 3.0
        self.imageview.layer.masksToBounds = true
    }
    
    
}
