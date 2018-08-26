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
import Alamofire
import NVActivityIndicatorView

private enum Constraint {
    static let profileUpdateHeight: CGFloat = 110.0
    static let userInfoEnrollment: CGFloat = 225.0
    static let defaultOneLineCell: CGFloat = 80.0
}

class ProfileViewController: UIViewController {

    private let oneLineData = ["출장을 떠나시나요?","도움말","호스트가 되어보세요","피드백 남기기","설정","로그아웃"]
    private let oneLineimage = ["arrow_right","ic_help_outline","home","edit","settings",""]
    private let profileService: ProfileServiceType = ProfileService()
    private let userdefault = UserDefaults.standard
    private var userDetailInfo: [String:Any] = [:]
    private var ref: DatabaseReference!
    private var activityView: NVActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
        setupActivityIndicator()
        
        activityView.startAnimating()
        
        fetchProfile()
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
    
    private func setupActivityIndicator() {
        activityView = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), padding: 25)
        
        activityView.backgroundColor = .white
        activityView.layer.cornerRadius = 10
        self.view.addSubview(activityView)
    }
    
    
    private func fetchProfile() {
        profileService.fetchProfile(token: UserDefaults.standard.string(forKey: "CurrentUserToken")!) { (result) in
            switch result {
            case .success(let userInfo):
                self.activityView.stopAnimating()
                
                print(userInfo)
                self.userDetailInfo["profileImage"] = userInfo.profileImage
                self.userDetailInfo["phoneNumber"] = userInfo.phoneNumber
                self.userDetailInfo["birthday"] = userInfo.birthday
                self.userDetailInfo["firstName"] = userInfo.firstName
                self.userDetailInfo["lastName"] = userInfo.lastName
                self.tableView.reloadData()
                
            case .failure(let error):
                self.activityView.stopAnimating()
                print(error)
            }
        }
    }
    //파이어베이스
//    private func fetchData() {
//
//        if let currentUserToken = userdefault.string(forKey: "CurrentUserToken") {
//            self.ref.child("Users").child(currentUserToken).observe(DataEventType.value, with: { (snapshot) in
//                self.activityView.stopAnimating()
//                let userInfo = snapshot.value! as! [String:Any]
//                self.userDetailInfo = userInfo
//
//                self.tableView.reloadData()
//            })
//        }
//    }

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
            case 0:
                let hostingVC = MoveStoryboard.toVC(storybardName: "Profile", identifier: "HostingViewController") as! HostingViewController
                self.present(hostingVC, animated: true, completion: nil)
            case oneLineData.count - 1:
                
                activityView.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.activityView.stopAnimating()
                    
                    UserDefaults.standard.removeObject(forKey: "CurrentUserToken")
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let entryVC = MoveStoryboard.toVC(storybardName: "Login", identifier: "EntryViewController") as! EntryViewController
                    let navigationController = UINavigationController(rootViewController: entryVC)
                    appDelegate.window?.rootViewController = navigationController
                    
                }
                
                
            default:
                print("asd;flkja;ldkf")
            }
        default:
            print("default")
        }

    }
    

}


