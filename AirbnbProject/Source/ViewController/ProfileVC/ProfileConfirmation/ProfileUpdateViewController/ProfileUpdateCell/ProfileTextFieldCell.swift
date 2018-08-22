//
//  ProfileTextFieldCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class ProfileTextFieldCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detailInfo: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        datePicker.datePickerMode = .date
//        datePicker.locale = Locale.init(identifier: "ko_KR")
//        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: UIControlEvents.valueChanged)
//        self.dateOfBirthTextField.inputView = datePicker
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
