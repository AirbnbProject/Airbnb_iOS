//
//  SaveListCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 10/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class SaveListCollectionCell: UICollectionViewCell {

    @IBOutlet weak var saveListImageView: UIImageView!
    @IBOutlet weak var saveListCityNameTitle: UILabel!
    @IBOutlet weak var saveListHouseNumberTitle: UILabel!
    
    var saveListBasicCityNameArray: Array<String> = ["Malibu", "Los Angeles", "Cape Town", "Rotterdam", "London", "Lecce", "Vesteroy", "Vesteroy", "Santorini"]
    var saveListBasicImageNameArray: Array<String> = [
        "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

}
