//
//  SignUpDateOfBirthViewController.swift
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

class SignUpDateOfBirthViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var dateOfBirthInvalidChecked: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var nextBtnViewBottom: NSLayoutConstraint!
    
    private let datePicker = UIDatePicker()
    
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
        
        //TODO:- 통신
        
        self.progressView.progress = 1.0
        UIView.animate(withDuration: 0.7) {
            self.progressView.layoutIfNeeded()
        }
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let signupEmailVC = storyboard.instantiateViewController(withIdentifier: "SignUpEmailVC")
        self.navigationController?.pushViewController(signupEmailVC, animated: true)
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
        
        setupDatePicker()

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
