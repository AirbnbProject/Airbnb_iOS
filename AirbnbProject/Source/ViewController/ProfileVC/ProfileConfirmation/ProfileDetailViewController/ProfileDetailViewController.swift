//
//  ProfileDetailViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var detailProfileImage: UIImageView!
    var profileImageData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = profileImageData {
            self.detailProfileImage.kf.setImage(with: URL(string: image), placeholder: UIImage(named: "profile"))
        }
    }
    
    deinit {
        print("ProfileDetailViewController deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
