//
//  BorderExtension.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 18..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 20, y: frame.height - size, width: frame.width - 40, height: size, color: color)
    }
    func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    private func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        
        border.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1).cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}
