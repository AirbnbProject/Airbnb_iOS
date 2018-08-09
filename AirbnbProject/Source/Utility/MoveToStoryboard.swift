//
//  MoveToStoryboard.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

struct MoveStoryboard {
    static func toVC(storybardName: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storybardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }
}
