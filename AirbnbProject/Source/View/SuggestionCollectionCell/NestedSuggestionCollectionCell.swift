//
//  SubSuggestionCollectionViewCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 31/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class NestedSuggestionCollectionCell: UICollectionViewCell {

    @IBOutlet weak var suggestionImageView: UIImageView!
    @IBOutlet weak var suggestionTitle: UILabel!
    @IBOutlet weak var suggestionView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.suggestionImageView.layer.cornerRadius = 5.0
        self.suggestionImageView.layer.masksToBounds = true
        
        self.suggestionView.layer.borderWidth = 0.2
        self.suggestionView.layer.cornerRadius = 5.0
        
        self.suggestionView.layer.masksToBounds = false
        self.suggestionView.layer.shadowColor = UIColor.gray.cgColor
        self.suggestionView.layer.shadowOpacity = 0.3
        self.suggestionView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.suggestionView.layer.shadowRadius = 4.0
        
    }

}
