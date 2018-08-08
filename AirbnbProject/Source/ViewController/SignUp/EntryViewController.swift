//
//  EntryViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    //MARK: - Property
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("EntryViewController Deinit")
    }

    //MARK: - Action
    @IBAction func moreOptions(_ sender: UIButton) {
        let moreOptionsVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "MoreOptionsVC")
        present(moreOptionsVC, animated: true) {
            print("옵션 더 보기 이동 성공")
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let signUpVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "SignUpNameVC")
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        let signInVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "SignInVC")
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}
