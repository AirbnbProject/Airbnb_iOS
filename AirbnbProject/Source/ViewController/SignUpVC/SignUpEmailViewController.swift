//
//  SignUpEmailViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 7. 31..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

//UI Constraint
private enum Constraint {
    static let originNextBtnBottom: CGFloat = 0
}

class SignUpEmailViewController: UIViewController, NVActivityIndicatorViewable {
    
    //TODO:- 이메일이 존재하는지 확인해야됨

    //MARK: - Property
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var errorContents: UILabel!
    @IBOutlet weak var nextBtnViewBottom: NSLayoutConstraint!
    
    private let authService: AuthServiceType = AuthService()
    private var activityView: NVActivityIndicatorView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupInitialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // presentingViewController 체크
        if self.isMovingToParentViewController == false { self.progressView.progress = 0.5 }
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
    
    //SignUpEmailVC -> SignUpNameVC
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func errorCloseButton(_ sender: UIButton) {
        self.errorContentView.isHidden = true
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {

        if sender == emailTextField {
            emailInvalidChecked.isHidden = false
            
            if (emailTextField.text?.count)! > 0 {
                self.errorContentView.isHidden = true
                if validateEmail(email: emailTextField.text!) {
                    emailInvalidChecked.image = UIImage(named: "check")
                }
            } else {
                self.nextBtn.isHighlighted = true
                self.errorContentView.isHidden = false
                self.errorContents.text = "유효한 이메일 주소를 입력해주세요."
                emailInvalidChecked.image = UIImage(named: "exclamationMark")
            }
        }
        
        self.nextBtn.isEnabled = isEnabledNextBtn()
        self.nextBtn.isHighlighted = isHighlightedNextBtn()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        guard (self.emailTextField.text?.count)! > 0 else { return }
        
        activityView.startAnimating()
        
        if validateEmail(email: self.emailTextField.text!) {
            
            authService.emailCheck(email: self.emailTextField.text!) { (result) in
                switch result {
                case .success(_):
                    print("email 중복 없음")
                    self.activityView.stopAnimating()
                    
                    UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                    
                    let signUpPasswordVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "SignUpPasswordVC")
                    self.navigationController?.pushViewController(signUpPasswordVC, animated: true)
                case .failure(let response, let error):
                    self.activityView.stopAnimating()
                    print(error)
                    if let data = response {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                            if let dictionary = json as? [String : AnyObject] {
                                let errorContent = dictionary["username"] as! [String]
                                    self.errorContents.text = errorContent[0]
                            }
                        }
                    }
                    self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
                    self.errorContentView.isHidden = false
                }
            }
        } else {
            self.activityView.stopAnimating()
            self.emailInvalidChecked.image = UIImage(named: "exclamationMark")
            self.errorContentView.isHidden = false
            self.errorContents.text = "유효한 이메일 주소를 입력해주세요."
        }
    }
    
    //MARK: - Method
    private func setupInitialize() {
        
        nextBtn.isEnabled = false
        nextBtn.isHighlighted = true
        errorContentView.isHidden = true
        
        setupActivityIndicator()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setupActivityIndicator() {
        
        activityView = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), padding: 25)
        
        activityView.backgroundColor = .white
        activityView.layer.cornerRadius = 10
        self.view.addSubview(activityView)
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

