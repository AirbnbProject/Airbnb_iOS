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
import Firebase

class EntryViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private let authService: AuthServiceType = AuthService()
    private let userDefault = UserDefaults.standard
    private var ref: DatabaseReference!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        setupButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    deinit {
        print("EntryViewController Deinit")
    }
    
    func setupButton() {
        self.facebookLoginButton.backgroundColor = .white
        self.facebookLoginButton.layer.cornerRadius = 3
        self.facebookLoginButton.setTitle("페이스북 계정으로 로그인", for: UIControlState.normal)
        self.facebookLoginButton.setTitleColor(UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), for: UIControlState.normal)
        
        self.createAccountButton.backgroundColor = .clear
        self.createAccountButton.layer.cornerRadius = 3
        self.createAccountButton.layer.borderWidth = 2
        self.createAccountButton.layer.borderColor = UIColor.white.cgColor
        self.createAccountButton.setTitle("계정 만들기", for: UIControlState.normal)
        self.createAccountButton.setTitleColor(.white, for: UIControlState.normal)
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
                    let firstName = resultData["first_name"] as! String
                    let lastName = resultData["last_name"] as! String
                    let id = resultData["id"] as! String
                    let picture = resultData["picture"] as! [String:Any]
                    let pictureData = picture["data"] as! [String:Any]
                    let profileImage = pictureData["url"] as? String

                    self.authService.facebookSignIn(email: email, id: id, firstName: firstName, lastName: lastName, url: profileImage!, completion: { (result) in
                        switch result {
                        case .success(let value):
                            print(value)
                            
                            UserDefaults.standard.set(value.token, forKey: "CurrentUserToken")
                            //파이어베이스에 Token 저장.
                            let currenUserToken = self.ref.child("Users")
                            let userDetailInfo = currenUserToken.child(value.token)
                            userDetailInfo.setValue([
                                "token":value.token,
                                "firstName":value.user.firstName,
                                "lastName":value.user.lastName,
                                "profileImage":value.user.profileImage ?? "",
                                "birthday":value.user.birthday ?? "",
                                "isHost":value.user.isHost,
                                "createDate":value.user.createDate])
                            
                            //TODO: - POST로 User Facebook 정보 보내기
                            //성공 -> 메인페이지 이동
                            
                            
                            
                        case .failure(let error):
                            print(error)
                        }
                    })
                })
            }
        }
    }
    
    //MARK: - Method

}

