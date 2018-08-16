//
//  NestedHorizontalStyleCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 01/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class NestedHorizontalStyleCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var horizontalStyleImage: UIImageView!
    
    @IBOutlet weak var horizontalStyleFistTitle: UILabel!
    @IBOutlet weak var horizontalStyleSecondTitle: UILabel!
    @IBOutlet weak var horizontalStyleSubTitle: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.horizontalStyleImage.layer.cornerRadius = 3.0
        self.horizontalStyleImage.layer.masksToBounds = true

    }

}
