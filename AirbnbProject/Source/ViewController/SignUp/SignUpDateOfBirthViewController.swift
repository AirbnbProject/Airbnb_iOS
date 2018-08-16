//
//  SignUpDateOfBirthViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 1..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

//UI Constraint
private enum Constraint {
    static let originNextBtnBottom: CGFloat = 0
}

class SignUpDateOfBirthViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var dateOfBirthInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var nextBtnViewBottom: NSLayoutConstraint!
    
    private let datePicker = UIDatePicker()
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
        if self.isMovingToParentViewController == false {
            self.progressView.progress = 1.0
        } else {
            self.progressView.progress = 0.5
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dateOfBirthTextField.becomeFirstResponder()
        
        self.progressView.progress = 0.75
        UIView.animate(withDuration: 0.7) {
            self.progressView.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SignUpDateOfBirthViewController Deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action
    
    //SignUpDateOfBirthVC -> SignUpPasswordVC
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {

        guard validateAdult() else {
            self.nextBtn.isEnabled = false
            self.nextBtn.isHighlighted = true
            self.errorContentView.isHidden = false
            return
        }
        
        activityView.startAnimating()
        
        UserDefaults.standard.set(dateOfBirthTextField.text!, forKey: "birthday")

        let firstName = UserDefaults.standard.object(forKey: "fristName") as! String
        let lastName = UserDefaults.standard.object(forKey: "lastName") as! String
        let email = UserDefaults.standard.object(forKey: "email")! as! String
        let birthday = UserDefaults.standard.object(forKey: "birthday")! as! String
        let password = UserDefaults.standard.object(forKey: "password")! as! String
        
        //TODO:- 통신
        authService.signUp(firstName: firstName, lastName: lastName, email: email, birthday: birthday, password: password, completion: { result in
            switch result {
            case .success(let userInfo):
                self.activityView.stopAnimating()
                
                print("회원가입 성공")
                print("UserInfo", userInfo)
                
                self.progressView.progress = 1.0
                UIView.animate(withDuration: 0.7) { self.progressView.layoutIfNeeded() }
                
                // 이메일 인증 Alert
                let alertController =  UIAlertController(title: "이메일 인증", message: "해당 이메일로 인증 메일이 발송되었습니다. 인증이 완료된 후 로그인이 가능합니다.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (_) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                // UserDefault내용 전체 삭제
                if let appDomain = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: appDomain)
                }
            case .failure(let error):
                self.activityView.stopAnimating()
                print(error)
            }
        })

    }

    @IBAction func errorCloseButton(_ sender: UIButton) {
        self.errorContentView.isHidden = true
    }
    
    //MARK: - Method
    private func setupInitialize() {
        
        nextBtn.isEnabled = false
        nextBtn.isHighlighted = false
        errorContentView.isHidden = true
        dateOfBirthTextField.delegate = self
        
        setupActivityIndicator()
        setupDatePicker()

    }

    private func setupActivityIndicator() {
        
        activityView = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), padding: 25)
        
        activityView.backgroundColor = .white
        activityView.layer.cornerRadius = 10
        self.view.addSubview(activityView)
    }
    
    private func setupDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: UIControlEvents.valueChanged)
        self.dateOfBirthTextField.inputView = datePicker
        
    }
    
    private func validateAdult() -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ko_kr")
        dateFormatter.dateFormat = "YYYY"
        
        let date = Date()
        let nowYear = dateFormatter.string(from: date)
        
        let inputYear = dateOfBirthTextField.text?.split(separator: ".")[0]
        let age = Int(nowYear)! - Int(inputYear!)! + 1
        
        print(Int(nowYear)! - Int(inputYear!)! + 1)
        
        if age >= 18 {
            return true
        }
        
        return false
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."
        self.dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
        
        self.nextBtn.isEnabled = true
        self.nextBtn.isHighlighted = false
        self.errorContentView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        nextBtnViewBottom.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SignUpDateOfBirthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        
        let datePickerHeight = datePicker.frame.height
        nextBtnViewBottom.constant = datePickerHeight
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
