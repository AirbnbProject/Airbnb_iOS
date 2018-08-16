//
//  ProfileViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 2..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

private enum Constraint {
    static let profileUpdateHeight: CGFloat = 110.0
    static let userInfoEnrollment: CGFloat = 225.0
    static let defaultOneLineCell: CGFloat = 80.0
}

class ProfileViewController: UIViewController {

    private let oneLineData = ["출장을 떠나시나요?","설정","도움말","호스트가 되어보세요","피드백 남기기"]
    private let oneLineimage = ["arrow_right","settings","ic_help_outline","home","edit"]
    private let profileService: ProfileServiceType = ProfileService()
    private let userdefault = UserDefaults.standard
    private var userDetailInfo: [String:Any] = [:]
    private var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
        fetchData()
    }
    
    deinit {
        print("ProfileViewController deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupInitialize() {
        
        ref = Database.database().reference()
        
        //네비게이션 Bottom Line Hidden
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "DefaultOneLineCell", bundle: nil), forCellReuseIdentifier: "DefaultOneLineCell")
    }
    
    private func fetchData() {
        
        if let currentUserToken = userdefault.string(forKey: "CurrentUserToken") {
            self.ref.child("Users").child(currentUserToken).observe(DataEventType.value, with: { (snapshot) in
                let userInfo = snapshot.value! as! [String:Any]
                self.userDetailInfo = userInfo
                
                self.tableView.reloadData()
            })
        }
    }

}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return oneLineData.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUpdateCell", for: indexPath) as! ProfileUpdateCell
                    
                    cell.name.text = self.userDetailInfo["firstName"] as? String
                    if let image = self.userDetailInfo["profileImage"] {
                        cell.profileImage.kf.setImage(with: URL(string: image as! String), placeholder: UIImage(named: "profile"))
                    }
                    
                    return cell
                
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoEnrollmentCell", for: indexPath) as! UserInfoEnrollmentCell
                    return cell
                
                default:
                    return UITableViewCell()
                }
        case 1:
            switch indexPath.row {
                case 0..<oneLineData.count:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultOneLineCell", for: indexPath) as! DefaultOneLineCell
                    
                    cell.infoTitle.text = oneLineData[indexPath.row]
                    cell.infoImage.image = UIImage(named: oneLineimage[indexPath.row])
                    
                    return cell
                default:
                    return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return Constraint.profileUpdateHeight
            case 1:
                return Constraint.userInfoEnrollment
            default:
                return 0
            }
        case 1:
            switch indexPath.row {
            case 0..<oneLineData.count:
                return Constraint.defaultOneLineCell
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let profileConfirmationVC = MoveStoryboard.toVC(storybardName: "Profile", identifier: "ProfileConfirmationViewController") as! ProfileConfirmationViewController
                profileConfirmationVC.userDetailInfo = self.userDetailInfo
                navigationController?.pushViewController(profileConfirmationVC, animated: true)
            default:
                print("section1")
            }
        case 1:
            switch indexPath.row {
            case 0..<oneLineData.count:
                print("asdl;kfadf")
            default:
                print("asd;flkja;ldkf")
            }
        default:
            print("default")
        }

    }
    

}


