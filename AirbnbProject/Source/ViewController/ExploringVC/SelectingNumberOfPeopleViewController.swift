//
//  DistributeGroupOfAgeViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 03/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class DistributeGroupOfAgeViewController: UIViewController {

    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var numberOfPeopleTitleLabel: UILabel!
    
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var currentNumberOfAdultLabel: UILabel!
    
    @IBOutlet weak var kidLabel: UILabel!
    @IBOutlet weak var ageRangeOfKidLabel: UILabel!
    @IBOutlet weak var currentNumberOfKidLabel: UILabel!
    
    @IBOutlet weak var infantLabel: UILabel!
    @IBOutlet weak var ageRangeOfInfantLabel: UILabel!
    @IBOutlet weak var currentNumberOfInfantLabel: UILabel!
    
    @IBOutlet weak var adultMinusBtn: UIButton!
    @IBOutlet weak var adultPlusBtn: UIButton!
    
    @IBOutlet weak var kidMinusBtn: UIButton!
    @IBOutlet weak var kidPlusBtn: UIButton!
    
    @IBOutlet weak var infantMinusBtn: UIButton!
    @IBOutlet weak var infantPlusBtn: UIButton!
    
    
    
    private var currentNumberOfAdult: Int = 1
    private var currentNumberOfKid: Int = 0
    private var currentNumberOfInfant: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setupButtonSetting()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "numberOfAdultState") == false
            && UserDefaults.standard.bool(forKey: "numberOfKidState") == false
            && UserDefaults.standard.bool(forKey: "numberOfInfantState") == false {
            
            currentNumberOfAdultLabel.text = "\(currentNumberOfAdult)"
            currentNumberOfKidLabel.text = "\(currentNumberOfKid)"
            currentNumberOfInfantLabel.text = "\(currentNumberOfInfant)"
        } else {
            currentNumberOfAdult = UserDefaults.standard.integer(forKey: "numberOfAdultState")
            currentNumberOfKid = UserDefaults.standard.integer(forKey: "numberOfKidState")
            currentNumberOfInfant = UserDefaults.standard.integer(forKey: "numberOfInfantState")
            
            currentNumberOfAdultLabel.text = "\(currentNumberOfAdult)"
            currentNumberOfKidLabel.text = "\(currentNumberOfKid)"
            currentNumberOfInfantLabel.text = "\(currentNumberOfInfant)"
        }
        
    }

    
    private func setupButtonSetting() {
        
        adultMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
        adultPlusBtn.setImage(UIImage(named: "plus_circle_highlighted"), for: .normal)
        
        kidMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
        kidPlusBtn.setImage(UIImage(named: "plus_circle_highlighted"), for: .normal)
        
        infantMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
        infantPlusBtn.setImage(UIImage(named: "plus_circle_highlighted"), for: .normal)
        
        self.resultView.layer.borderWidth = 0.2
        self.resultView.layer.borderColor = UIColor.gray.cgColor
        self.resultView.layer.cornerRadius = 5.0
        
        self.resultView.layer.masksToBounds = false
        self.resultView.layer.shadowColor = UIColor.gray.cgColor
        self.resultView.layer.shadowOpacity = 0.3
        self.resultView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.resultView.layer.shadowRadius = 4.0
        
        
    }
    
    @IBAction func subtractNumberOfAdult(_ sender: UIButton) {
        
        if currentNumberOfAdult == 1 {
            return print("Min 1")
        } else {
            currentNumberOfAdult -= 1
            currentNumberOfAdultLabel.text = "\(currentNumberOfAdult)"
            
            if currentNumberOfAdultLabel.text == "1" {
                adultMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
            } else {
                adultPlusBtn.setImage(UIImage(named: "plus_circle_highlighted"), for: .normal)
            }
        }
    }
    
    @IBAction func plusNumberOfAdult(_ sender: UIButton) {
        
        if currentNumberOfAdult == 16 {
            return print("Max 16")
        } else {
            currentNumberOfAdult += 1
            currentNumberOfAdultLabel.text = "\(currentNumberOfAdult)"
            
            if currentNumberOfAdultLabel.text == "16" {
                adultPlusBtn.setImage(UIImage(named: "plus_circle"), for: .normal)
            } else {
                adultMinusBtn.setImage(UIImage(named: "minus_circle_highlighted"), for: .normal)
            }
        }
    }
    
    @IBAction func subtractNumberOfKid(_ sender: UIButton) {
        if currentNumberOfKid == 0 {
            return print("Min 0")
        } else {
            currentNumberOfKid -= 1
            currentNumberOfKidLabel.text = "\(currentNumberOfKid)"
            
            if currentNumberOfKidLabel.text == "0" {
                kidMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
            } else {
                kidPlusBtn.setImage(UIImage(named: "plus_circle_highlighted"), for: .normal)
            }
        }
    }
    
    @IBAction func plusNumberOfKid(_ sender: UIButton) {
        if currentNumberOfKid == 5 {
            return print("Max 5")
        } else {
            currentNumberOfKid += 1
            currentNumberOfKidLabel.text = "\(currentNumberOfKid)"
            
            if currentNumberOfKidLabel.text == "5" {
                kidPlusBtn.setImage(UIImage(named: "plus_circle"), for: .normal)
            } else {
                kidMinusBtn.setImage(UIImage(named: "minus_circle_highlighted"), for: .normal)
            }
        }
    }
    
    @IBAction func subtractNumberOfInfant(_ sender: UIButton) {
        if currentNumberOfInfant == 0 {
            return print("Min 0")
        } else {
            currentNumberOfInfant -= 1
            currentNumberOfInfantLabel.text = "\(currentNumberOfInfant)"
            
            if currentNumberOfInfantLabel.text == "0" {
                infantMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
            } else {
                infantPlusBtn.setImage(UIImage(named: "plus_circle_highlighted"), for: .normal)
            }
        }
    }
    
    
    @IBAction func plusNumberOfInfant(_ sender: UIButton) {
        if currentNumberOfInfant == 5 {
            return print("Max 5")
        } else {
            currentNumberOfInfant += 1
            currentNumberOfInfantLabel.text = "\(currentNumberOfInfant)"
            if currentNumberOfInfantLabel.text == "5" {
                infantPlusBtn.setImage(UIImage(named: "plus_circle"), for: .normal)
            } else {
                infantMinusBtn.setImage(UIImage(named: "minus_circle_highlighted"), for: .normal)
            }
        }
    }
    
    // NOTIFICATION CENTER : PREPARE TO SEND PERSON COUNT INFORMATION BY SORTING AGE GROUP
    
    @IBAction func showResultBtn(_ sender: UIButton) {
//        let sendConntAdultNumber = currentNumberOfAdult
//        let sendCountKidNumber = currentNumberOfKid
//        let sendCountInfantNumber = currentNumberOfInfant
        
        let alertController = UIAlertController.init(
            title: "선택하신 인원입니다",
            message: "성인 : \(currentNumberOfAdult)명, 어린이 : \(currentNumberOfKid)명, 유아 : \(currentNumberOfInfant)명", preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
            
            // 기존에 정의되어 있지 않은 Noti 를 만들고자 할 때에는 .post 를 활용.
            // deinit 으로 따로 정의해줘야하나........???*********************
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "getCountInfo"),
                object: nil,
                userInfo: ["adult" : self.currentNumberOfAdult,
                           "kid": self.currentNumberOfKid,
                           "infant": self.currentNumberOfInfant
                ]
            )
            // name 은 새로 만드는 Noti의 이름을 받는 param, object는 'sender', userInfo는 '가입자에게 보내게 될 정보(딕셔너리 형태)'.
        }
        
        let secondAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        present(alertController, animated: true)

        UserDefaults.standard.set(currentNumberOfAdult, forKey: "numberOfAdultState")
        UserDefaults.standard.set(currentNumberOfKid, forKey: "numberOfKidState")
        UserDefaults.standard.set(currentNumberOfInfant, forKey: "numberOfInfantState")
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.presentingViewController?.dismiss(animated: true)
    }
    
}
