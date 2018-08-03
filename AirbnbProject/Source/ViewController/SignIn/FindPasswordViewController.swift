//
//  FindPasswordViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 2..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

//UI Constraint
private enum Constraint {
    static let originBackBtnTop: CGFloat = 10
    static let originNextBtnBottom: CGFloat = 0
}

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var errorContents: UILabel!
    
    @IBOutlet weak var backBtnTop: NSLayoutConstraint!
    @IBOutlet weak var nextBtnViewBottom: NSLayoutConstraint!
    
    
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
        print("FindPasswordViewController Deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action
    
    //FindPasswordVC -> SignInVC
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func errorCloseButton(_ sender: UIButton) {
        self.errorContentView.isHidden = true
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        guard (self.emailTextField.text?.count)! > 0 else { return }
        
        if validateEmail(email: self.emailTextField.text!) {
            
            //TODO:- 유저 통신 로직 추가
            print("로그인 성공")
            
            let alertController = UIAlertController(title: "이메일을 확인해보세요", message: "\(self.emailTextField.text!)(으)로 이메일을 보내드렸습니다. 이메일에 포함된 링크를 탭하여 비밀번호를 다시 설정하세요.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (alert)in
                //SignInVC로 이동.
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true) {
                print("OK")
            }
            
        } else {
            self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
            self.errorContentView.isHidden = false
            self.errorContents.text = "유효한 이메일 주소를 입력하세요."
        }
        
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if (emailTextField.text?.count)! > 0 {
            
            if let email = emailTextField.text {
                if validateEmail(email: email) {
                    emailInvalidChecked.image = UIImage(named: "check")
                    errorContentView.isHidden = true
                }
            }
        }
        
        nextBtn.isEnabled = isEnabledNextBtn()
        nextBtn.isHighlighted = isHighlightedNextBtn()

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
        
        // 키보드에 화면이 가려질 경우.
        if keyboardFrame.origin.y < self.emailTextField.frame.maxY {
            self.backBtnTop.constant = -(self.emailTextField.frame.maxY - keyboardHeight + self.emailTextField.frame.height)
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
    
    //Email 정규식
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
