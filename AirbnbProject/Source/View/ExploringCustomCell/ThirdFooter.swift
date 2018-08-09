//
//  ThirdFooter.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

protocol FooterDelegate: class {
    func FooterCell(_ itemCell: ThirdFooter, didTapAddButton: UIButton)
}

class ThirdFooter: UICollectionViewCell {
    
    weak var delegate: FooterDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func moreClick(_ sender: Any) {
        delegate?.FooterCell(self, didTapAddButton: sender as! UIButton)
    }
}
