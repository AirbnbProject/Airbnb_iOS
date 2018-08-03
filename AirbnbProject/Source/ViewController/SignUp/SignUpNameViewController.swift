//
//  SignUpNameViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

//UI Constraint
private enum Constraint {
    static let originBackBtnTop: CGFloat = 10
    static let originNextBtnBottom: CGFloat = 0
}

class SignUpNameViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameInvalidChecked: UIImageView!
    @IBOutlet weak var lastNameInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var errorContents: UILabel!
    
    @IBOutlet weak var backBtnTop: NSLayoutConstraint!
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
            self.progressView.progress = 0.25
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        firstNameTextField.becomeFirstResponder()

        // ProgressBar 애니메이션
        self.progressView.progress = 0.0
        UIView.animate(withDuration: 0.7, animations: {
            self.progressView.layoutIfNeeded()
        }, completion: nil)
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SignUpNameViewController Deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Action
    
    //SignUpNameVC -> MoreOptions
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let signupEmailVC = storyboard.instantiateViewController(withIdentifier: "SignUpEmailVC")
        self.navigationController?.pushViewController(signupEmailVC, animated: true)
    }
    
    @IBAction func errorCloseButton(_ sender: UIButton) {
        self.errorContentView.isHidden = true
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {

        if sender == firstNameTextField {
            firstNameInvalidChecked.isHidden = false
            
            if (firstNameTextField.text?.count)! > 0 {
                self.errorContentView.isHidden = true
                firstNameInvalidChecked.image = UIImage(named: "check")
                
            } else {
                self.nextBtn.isHighlighted = true
                self.errorContentView.isHidden = false
                self.errorContents.text = "이름을 입력하셔야 합니다."
                firstNameInvalidChecked.image = UIImage(named: "exclamationMark")
            }
        } else {
            lastNameInvalidChecked.isHidden = false
            
            if (lastNameTextField.text?.count)! > 0 {
                self.errorContentView.isHidden = true
                lastNameInvalidChecked.image = UIImage(named: "check")
            } else {
                self.nextBtn.isHighlighted = true
                self.errorContentView.isHidden = false
                self.errorContents.text = "성을 입력하셔야 합니다."
                lastNameInvalidChecked.image = UIImage(named: "exclamationMark")
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
        firstNameInvalidChecked.isHidden = true
        lastNameInvalidChecked.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func isEnabledNextBtn() -> Bool {
        if (self.firstNameTextField.text?.count)! > 0 && (self.lastNameTextField.text?.count)! > 0 {
            return true
        }
        return false
    }
    
    private func isHighlightedNextBtn() -> Bool {
        if (self.firstNameTextField.text?.count)! > 0 && (self.lastNameTextField.text?.count)! > 0 {
            return false
        }
        return true
    }
    
    @objc private func keyboardWillShow(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height
        
        self.nextBtnViewBottom.constant = keyboardHeight
        
        // 키보드에 화면이 가려질 경우.
        if keyboardFrame.origin.y < self.lastNameTextField.frame.maxY {
            self.backBtnTop.constant = -(self.lastNameTextField.frame.maxY - keyboardHeight + self.lastNameTextField.frame.height)
        }
        
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        
        self.backBtnTop.constant = Constraint.originBackBtnTop
        self.nextBtnViewBottom.constant = Constraint.originNextBtnBottom
        
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


