//
//  NestedHorizontalStyleCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 01/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

protocol NestedHorizontalStyleDelegate: class {
    func showTypeOfTrip()
}

class NestedHorizontalStyleCollectionCell: UICollectionViewCell {

    // SET NESTED HORIZONTAL STYLE COLLECTION VIEW CELL'S PROPERTY
    let setTypeOfImages = ["familyTrip", "businessTrip"]
    
    @IBOutlet weak var horizontalStyleImage: UIImageView!
    @IBOutlet weak var horizontalStyleFirstTitle: UILabel!
    @IBOutlet weak var horizontalStyleSecondTitle: UILabel!
    @IBOutlet weak var horizontalStyleSubTitle: UILabel!
    
    weak var delegate: NestedHorizontalStyleDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // INDEXPATH.ROW 에 이미지를 다르게 주고 싶은데, 델리게이트 사용도 안되고 미치겠다.
        
        self.horizontalStyleImage.layer.cornerRadius = 3.0
        self.horizontalStyleImage.layer.masksToBounds = true

    }

}
