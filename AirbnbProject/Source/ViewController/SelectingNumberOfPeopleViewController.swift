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
    
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    
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
    
    
    var currentNumberOfAdult: Int = 1
    var currentNumberOfKid: Int = 1
    var currentNumberOfInfant: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentNumberOfAdultLabel.text = "1"
        currentNumberOfKidLabel.text = "1"
        currentNumberOfInfantLabel.text = "1"
        
    }
    
    
    @IBAction func subtractNumberOfAdult(_ sender: UIButton) {
        if currentNumberOfAdultLabel.text == "1" {
            currentNumberOfAdultLabel.text = "1"
            print("Min 1")
            adultMinusBtn.setImage(UIImage(named: "minus_circle_highlighted"), for: .normal
            )
            
            } else {
            currentNumberOfAdult -= 1
            currentNumberOfAdultLabel.text = "\(currentNumberOfAdult)"
            if currentNumberOfAdultLabel.text == "1" {
                adultMinusBtn.setImage(UIImage(named: "minus_circle"), for: .normal)
            }
        }
        
    }
    
    @IBAction func plusNumberOfAdult(_ sender: UIButton) {
        if currentNumberOfAdultLabel.text == "16" {
            currentNumberOfAdultLabel.text = "16"
            print("Max 16")
        } else {
            currentNumberOfAdult += 1
            currentNumberOfAdultLabel.text = "\(currentNumberOfAdult)"
        }
    }
    
    @IBAction func subtractNumberOfKid(_ sender: UIButton) {
        if currentNumberOfKidLabel.text == "1" {
            currentNumberOfKidLabel.text = "1"
            print("Min 1")
        } else {
            currentNumberOfKid -= 1
            currentNumberOfKidLabel.text = "\(currentNumberOfKid)"
        }
    }
    
    @IBAction func plusNumberOfKid(_ sender: UIButton) {
        if currentNumberOfKidLabel.text == "5" {
            currentNumberOfKidLabel.text = "5"
            print("Max 5")
        } else {
            currentNumberOfKid += 1
            currentNumberOfKidLabel.text = "\(currentNumberOfKid)"
        }
    }
    
    @IBAction func subtractNumberOfInfant(_ sender: UIButton) {
        if currentNumberOfInfantLabel.text == "1" {
            currentNumberOfInfantLabel.text = "1"
            print("Min 1")
        } else {
            currentNumberOfInfant -= 1
            currentNumberOfInfantLabel.text = "\(currentNumberOfInfant)"
        }
    }
    
    
    @IBAction func plusNumberOfInfant(_ sender: UIButton) {
        if currentNumberOfInfantLabel.text == "5" {
            currentNumberOfInfantLabel.text = "5"
            print("Max 5")
        } else {
            currentNumberOfInfant += 1
            currentNumberOfInfantLabel.text = "\(currentNumberOfInfant)"
        }
    }
    
    
    @IBAction func showResultBtn(_ sender: UIButton) {
        
        
        
    }
    
    
    
}
