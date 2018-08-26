//
//  TravelViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 23..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController {

    @IBOutlet weak var circleView: UIImageView!
    @IBOutlet weak var tourButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.layer.masksToBounds = true
        
        tourButton.layer.cornerRadius = 5
        tourButton.layer.borderWidth = 2
        tourButton.layer.borderColor = UIColor(red: 12/255.0, green: 131/255.0, blue: 137/255.0, alpha: 1).cgColor
        tourButton.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToExploring(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
