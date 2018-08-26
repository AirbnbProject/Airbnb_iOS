//
//  ReportNextCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 13..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

protocol ReportNextDelegate: class {
    func ReportNextCell(_ itemCell: ReportNextCell, didTapAddButton: UIButton)
}

class ReportNextCell: UICollectionViewCell {
    
    weak var delegate: ReportNextDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func goNext(_ sender: Any) {
        delegate?.ReportNextCell(self, didTapAddButton: sender as! UIButton)
    }
}
