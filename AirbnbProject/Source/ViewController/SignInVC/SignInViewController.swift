//
//  SignInViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 1..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

//UI Constraint
private enum Constraint {
    static let originBackBtnTop: CGFloat = 10
    static let originNextBtnBottom: CGFloat = 0
}

class SignInViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailInvalidChecked: UIImageView!
    @IBOutlet weak var passwordInvalidChecked: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var errorContents: UILabel!
    
    @IBOutlet weak var backBtnTop: NSLayoutConstraint!
    @IBOutlet weak var loginBtnViewBottom: NSLayoutConstraint!
    
    private let authService: AuthServiceType = AuthService()
    private var activityView: NVActivityIndicatorView!
    private var userDefault = UserDefaults.standard
    private var ref: DatabaseReference!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.becomeFirstResponder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SignInViewController Deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Method
    
    private func setupInitialize() {
        
        self.ref = Database.database().reference()
        
        loginBtn.isEnabled = false
        loginBtn.isHighlighted = true
        errorContentView.isHidden = true
        
        setupActivityIndicator()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    //MARK: - Action
    
    //SignInVC -> EntryVC
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func errorCloseButton(_ sender: UIButton) {
        self.errorContentView.isHidden = true
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if (emailTextField.text?.count)! > 0 && (passwordTextField.text?.count)! > 0 {
            loginBtn.isEnabled = true
            loginBtn.isHighlighted = false
        }
        
        if let email = emailTextField.text {
            if validateEmail(email: email) {
                emailInvalidChecked.image = UIImage(named: "check")
                errorContentView.isHidden = true
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard (self.emailTextField.text?.count)! > 0 else { return }
        
        activityView.startAnimating()
        
        if validateEmail(email: self.emailTextField.text!) {
            
            authService.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (result) in
                switch result {
                case .success(let value):
                    print("로그인 성공")
                    self.activityView.stopAnimating()
                    
                    UserDefaults.standard.set(value.token, forKey: "CurrentUserToken")
                    let currentUser = self.ref.child("Users").child(value.token)
                    currentUser.setValue([
                        "token":value.token,
                        "firstName":value.user.firstName,
                        "lastName":value.user.lastName,
                        "profileImage":value.user.profileImage ?? "",
                        "birthday":value.user.birthday ?? "",
                        "isHost":value.user.isHost,
                        "createDate":value.user.createDate])
                    
                    let mainVC = MoveStoryboard.toVC(storybardName: "Main", identifier: "MainExploring")
                    self.show(mainVC, sender: nil)
                    
                    
                case .failure(let response, let error):
                    self.activityView.stopAnimating()

                    if let data = response {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                            if let dictionary = json as? [String : AnyObject] {
                                var errorContent = dictionary["username"] as? [String] ?? dictionary["non_field_errors"] as? [String]
                                self.errorContents.text = errorContent?[0]
                                self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
                                self.errorContentView.isHidden = false
                            }
                        }
                    }
                    print(error)
                }
            }
            
            
        } else {
            activityView.stopAnimating()
            self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
            self.errorContentView.isHidden = false
            self.errorContents.text = "유효한 이메일 주소를 입력하세요."
        }
    }
    
    @IBAction func findPasswordButton(_ sender: UIButton) {
        let findPasswordVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "FindPasswordVC")
        self.navigationController?.pushViewController(findPasswordVC, animated: true)
    }
    
    
    @IBAction func toggleSecureText(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    
    private func setupActivityIndicator() {
        activityView = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), padding: 25)
        
        activityView.backgroundColor = .white
        activityView.layer.cornerRadius = 10
        self.view.addSubview(activityView)
    }
    
    @objc private func keyboardWillShow(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height
        
        self.loginBtnViewBottom.constant = keyboardHeight
        
        // 키보드에 화면이 가려질 경우.
        if keyboardFrame.origin.y < self.passwordTextField.frame.maxY {
            self.backBtnTop.constant = -(self.passwordTextField.frame.maxY - keyboardHeight + self.passwordTextField.frame.height)
        }

        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        
        self.backBtnTop.constant = Constraint.originBackBtnTop
        self.loginBtnViewBottom.constant = Constraint.originNextBtnBottom
        
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    //Email 정규식
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
