//
//  EntryViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class EntryViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet weak var facebookLoginButton: UIButton!
    
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
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if (error != nil){
                print(error as Any)
                return
            } else if (result?.isCancelled)! {
                print("Cancelled")
            } else {
                print("Login",result?.token.tokenString as Any)
                
                let parameters = ["fields":"email, first_name, last_name, picture.type(large)"]
                FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) in
                    
                    if error != nil {
                        print(error!)
                        print(result as! String)
                    }
                    
                    let resultData = result! as! [String:Any]
                    print(resultData)
                    let email = resultData["email"] as! String
                    let userName = "\(resultData["last_name"] as! String)" + "\(resultData["first_name"] as! String)"
                    let picture = resultData["picture"] as! [String:Any]
                    let pictureData = picture["data"] as! [String:Any]
                    let profileImage = pictureData["url"] as! String
                    
                    
                    //TODO: - POST로 User Facebook 정보 보내기
                    
                    //성공 -> 메인페이지 이동
                    
                })
            }
        }
    }
    
    //MARK: - Method
    
    
}

