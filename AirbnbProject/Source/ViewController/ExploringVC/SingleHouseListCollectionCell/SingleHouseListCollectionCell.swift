//
//  SingleHouseListCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 15/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

protocol PresentDetailVCDelegate: class {
    func presentDetailVC()
}

class SingleHouseListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var SingleHouseListImageView: UIImageView!
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var regionTitle: UILabel!
    @IBOutlet weak var houseTitle: UILabel!
    @IBOutlet weak var currencySymbolTitle: UILabel! // e.g) $
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var byDayTitle: UILabel!
    
    weak var delegate: PresentDetailVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SingleHouseListImageView.layer.cornerRadius = 3.0
        self.SingleHouseListImageView.layer.masksToBounds = true
        delegate?.presentDetailVC()
    }
    
}
