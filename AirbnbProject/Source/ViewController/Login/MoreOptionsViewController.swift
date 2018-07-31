//
//  MoreOptionsViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class MoreOptionsViewController: UIViewController {

    //MARK: - Property
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("MoreOptionsViewController Deinit")
    }

    //MARK: - Action
    
    //MoreOptions -> EntryVC
    @IBAction func CloseButton(_ sender: UIButton) {
        dismiss(animated: true) {
            print("EntryVC로 이동 성공")
        }
    }
    
    

}
