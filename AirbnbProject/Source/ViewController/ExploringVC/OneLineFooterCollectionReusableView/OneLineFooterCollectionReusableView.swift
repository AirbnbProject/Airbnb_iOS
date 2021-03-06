//
//  OneLineFooterCollectionReusableView.swift
//  AirbnbProject
//
//  Created by 박인수 on 01/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

protocol OneLineFooterDelegate: class {
    func pushShowEverythingVC(footerView: UICollectionReusableView)
}

class OneLineFooterCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var oneLineFooterBtn: UIButton!
    
    weak var delegate: OneLineFooterDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        oneLineFooterBtn.layer.borderWidth = 0.4
        // oneLineFooterBtn.layer.borderColor = (Insert AirBnb Color) -> Red 12/255.0 , Green 131/255.0 , / Blue 137/255.0
        oneLineFooterBtn.layer.borderColor = UIColor(red: 0.047058823529412, green: 0.513725490196078, blue: 0.537254901960784, alpha: 1.0).cgColor
        oneLineFooterBtn.layer.cornerRadius = 5.0
        oneLineFooterBtn.layer.masksToBounds = true
        oneLineFooterBtn.setTitleColor(UIColor(red: 0.047058823529412, green: 0.513725490196078, blue: 0.537254901960784, alpha: 1.0), for: .normal)
        
    }
    
    @IBAction func clickFooterBtn(_ sender: UIButton) {
        print("Click Footer Button")
        delegate?.pushShowEverythingVC(footerView: self)
    }
}

