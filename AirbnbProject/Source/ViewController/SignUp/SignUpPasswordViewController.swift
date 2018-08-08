//
//  SignUpPasswordViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 31..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

//UI Constraint
private enum Constraint {
    static let originNextBtnBottom: CGFloat = 0
}

class SignUpPasswordViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    
    @IBOutlet weak var nextBtnViewBottom: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // presentingViewController 체크
        if self.isMovingToParentViewController == false {
            self.progressView.progress = 0.75
        } else {
            self.progressView.progress = 0.25
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        passwordTextField.becomeFirstResponder()
        
        self.progressView.progress = 0.5
        UIView.animate(withDuration: 0.7) {
            self.progressView.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SignUpPasswordViewController Deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action
    
    //SignUpPasswordVC -> SignUpEmailVC
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        guard (self.passwordTextField.text?.count)! > 7 else { return }
        
        //특수 문자를 포함한 8자 이상 체크
        if validatePassword(password: self.passwordTextField.text!) {
            UserDefaults.standard.set(passwordTextField.text!, forKey: "password")
            
            let signUpDateOfBirthVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "SignUpDateOfBirthVC")
            self.navigationController?.pushViewController(signUpDateOfBirthVC, animated: true)
        } else {
            self.nextBtn.isEnabled = false
            self.nextBtn.isHighlighted = true
            self.errorContentView.isHidden = false
        }
    }
    
    @IBAction func toggleSecureText(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        
        if sender == passwordTextField {

            if (passwordTextField.text?.count)! > 0 {
                self.errorContentView.isHidden = true
                
                if let pw = self.passwordTextField.text {
                    if validatePassword(password: pw) {
                        self.passwordInvalidChecked.image = UIImage(named: "check")
                    }
                }
            } else {
                self.nextBtn.isHighlighted = true
                self.errorContentView.isHidden = false
            }
        }

        self.nextBtn.isEnabled = isEnabledNextBtn()
        self.nextBtn.isHighlighted = isHighlightedNextBtn()
    }
    
    
    //MARK: - Method
    private func setupInitialize() {
        
        nextBtn.isEnabled = false
        nextBtn.isHighlighted = true
        errorContentView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height
        
        self.nextBtnViewBottom.constant = keyboardHeight
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        
        self.nextBtnViewBottom.constant = Constraint.originNextBtnBottom
        
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func isEnabledNextBtn() -> Bool {
        if (self.passwordTextField.text?.count)! > 0 {
            return true
        }
        return false
    }
    
    private func isHighlightedNextBtn() -> Bool {
        if (self.passwordTextField.text?.count)! > 0 {
            return false
        }
        return true
    }
    
    func validatePassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,50}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
