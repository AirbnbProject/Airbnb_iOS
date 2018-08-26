//
//  ReportCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 13..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

protocol ReportDelegate: class {
    func ReportRadioCell(_ itemCell: ReportCell, didTapAddButton: UIButton)
}

class ReportCell: UICollectionViewCell {

    @IBOutlet weak var reportBtn: UIButton!
    @IBOutlet weak var reportLabel: UILabel!
    
    weak var delegate: ReportDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reportBtn.layer.cornerRadius = self.reportBtn.frame.width / 2
        reportBtn.layer.masksToBounds = true//원모양으로만듬
    }

    @IBAction func clickRadioBtn(_ sender: Any) {
        delegate?.ReportRadioCell(self, didTapAddButton: sender as! UIButton)
    }
}
