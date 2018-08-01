//
//  SignInViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 1..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

//UI Constraint
private enum Constraint {
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
        
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SignInViewController Deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        if validateEmail(email: self.emailTextField.text!) {
            
            // 유저 통신 로직 추가
            print("로그인 성공")
            
        } else {
            self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
            self.errorContentView.isHidden = false
            self.errorContents.text = "유효한 이메일 주소를 입력하세요."
        }
    }
    
    @IBAction func toggleSecureText(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    
    //MARK: - Method
    
    private func setupInitialize() {
        
        loginBtn.isEnabled = false
        loginBtn.isHighlighted = true
        errorContentView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height
        
        self.loginBtnViewBottom.constant = keyboardHeight
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        
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
