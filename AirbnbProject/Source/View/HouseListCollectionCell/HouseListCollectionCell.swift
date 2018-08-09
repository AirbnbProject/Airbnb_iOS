//
//  HouseInTheWorldCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 31/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class HouseListCollectionCell: UICollectionViewCell {

    // 아직 연결 안되어 있음. 연결 후 삭제 요망.
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var regionTitle: UILabel!
    @IBOutlet weak var houseTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var participationCountTitle: UILabel!
    @IBOutlet weak var favoriteCheckBtn: UIButton!
    
    @IBOutlet weak var houseImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.houseImageView.layer.cornerRadius = 3.0
        self.houseImageView.layer.masksToBounds = true
    }
    
    @IBAction func favoriteCheckBtnDidTap(_ sender: UIButton) {
        favoriteCheckBtn.isSelected = !favoriteCheckBtn.isSelected
        print("isSelected", favoriteCheckBtn.isSelected)
        
        if favoriteCheckBtn.isSelected == true {
            favoriteCheckBtn.setImage(UIImage(named: "loveIconDidPushed"), for: .normal)
        } else {
            favoriteCheckBtn.setImage(UIImage(named: "loveIconDefault"), for: .normal)
        }
        
        
    }
    
}
