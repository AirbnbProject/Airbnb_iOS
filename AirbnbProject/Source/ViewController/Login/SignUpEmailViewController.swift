//
//  SignUpEmailViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 31..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

//UI Constraint
private enum Constraint {
    static let originBackBtnTop: CGFloat = 10
    static let originNextBtnBottom: CGFloat = 0
}

class SignUpEmailViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    
    @IBOutlet weak var nextBtnViewBottom: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.becomeFirstResponder()
        
        self.progressView.progress = 0.25
        UIView.animate(withDuration: 0.7) {
            self.progressView.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SignUpEmailViewController Deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Action
    
    //SignUpNameVC -> MoreOptions
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {

        if sender == emailTextField {
            emailInvalidChecked.isHidden = false
            
            if (emailTextField.text?.count)! > 0 {
                self.errorContentView.isHidden = true
            } else {
                self.nextBtn.isHighlighted = true
                self.errorContentView.isHidden = false
                emailInvalidChecked.image = UIImage(named: "exclamationMark")
            }
        }
        
        self.nextBtn.isEnabled = isEnabledNextBtn()
        self.nextBtn.isHighlighted = isHighlightedNextBtn()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        guard (self.emailTextField.text?.count)! > 0 else { return }
        
        if validateEmail(email: self.emailTextField.text!) {
            print("validate")
            //        let storyboard = UIStoryboard(name: "Login", bundle: nil)
            //        let signupEmailVC = storyboard.instantiateViewController(withIdentifier: "SignUpEmailVC")
            //        self.navigationController?.pushViewController(signupEmailVC, animated: true)
        } else {
            self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
            self.errorContentView.isHidden = false
        }
        
        

    }
    
    //MARK: - Method
    private func setupInitialize() {
        
        nextBtn.isEnabled = false
        nextBtn.isHighlighted = true
        errorContentView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func isEnabledNextBtn() -> Bool {
        if (self.emailTextField.text?.count)! > 0 {
            return true
        }
        return false
    }
    
    private func isHighlightedNextBtn() -> Bool {
        if (self.emailTextField.text?.count)! > 0 {
            return false
        }
        return true
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
    
    
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
