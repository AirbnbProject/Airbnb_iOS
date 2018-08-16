//
//  ProfileConfirmationViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 9..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import Firebase

private enum Constraint {
    static let profileUpdateHeight: CGFloat = 110.0
    static let defaultCell: CGFloat = 100.0
}

class ProfileConfirmationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let profileDetailInfo = ["","회원가입일","인증된 정보"]
    
    var userDetailInfo: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("ProfileConfirmationViewController deinit")
    }
    
    //MARK: - Method
    
    private func setupInitialize() {
        
        //네비게이션 Bottom Line Hidden
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.dataSource = self
        tableView.delegate = self

        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
    
        let leftButton = UIButton(type: UIButtonType.custom)
        leftButton.setImage(UIImage(named: "arrow_left_black"), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(backButtonAction), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftButton)
        navigationItem.setLeftBarButton(leftItem, animated: true)
        
        let updateButton = UIButton(type: UIButtonType.custom)
        updateButton.setAttributedTitle(NSAttributedString(string: "수정", attributes: [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 13)!]), for: .normal)
        updateButton.setTitleColor(.black, for: .normal)
        updateButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        updateButton.addTarget(self, action: #selector(updateProfileAction), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem(customView: updateButton)
        navigationItem.setRightBarButton(rightItem, animated: true)
        
    }
    
    @objc private func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func updateProfileAction() {
        let profileUpdateVC = MoveStoryboard.toVC(storybardName: "Profile", identifier: "ProfileUpdateViewController") as! ProfileUpdateViewController
        profileUpdateVC.userDetailInfo = userDetailInfo
        present(profileUpdateVC, animated: true, completion: nil)
    }
}

extension ProfileConfirmationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileDetailInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUpdateCell", for: indexPath) as! ProfileUpdateCell
                
                cell.delegate = self
                
                cell.name.text = (self.userDetailInfo["firstName"] as? String)! + " " + (self.userDetailInfo["lastName"] as? String)!
                if let image = self.userDetailInfo["profileImage"] {
                    cell.profileImage.kf.setImage(with: URL(string: image as! String), placeholder: UIImage(named: "profile"))
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileConfirmationDefaultCell", for: indexPath) as! ProfileConfirmationDefaultCell
                cell.detailTitle.text = profileDetailInfo[indexPath.row]
                cell.detailInfo.text = userDetailInfo["createDate"] as? String
                return cell
            default:
//                https://www.airbnb.co.kr/help/article/1237/how-does-it-work-when-airbnb-asks-for-an-id
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileConfirmationDefaultCell", for: indexPath) as! ProfileConfirmationDefaultCell
                cell.detailTitle.text = profileDetailInfo[indexPath.row]
                cell.detailInfo.text = "이메일 주소"
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileConfirmationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return Constraint.profileUpdateHeight
            default:
                return Constraint.defaultCell
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            let authenticatedInfoVC =  MoveStoryboard.toVC(storybardName: "Profile", identifier: "AuthenticatedInfoViewController")
            self.navigationController?.pushViewController(authenticatedInfoVC, animated: true)
        }
        
    }
}

extension ProfileConfirmationViewController: ProfileUpdateCellDelegate {
    
    func profileImageDidSelect(profileImage: UIImage?) {
        let profileDetailVC = MoveStoryboard.toVC(storybardName: "Profile", identifier: "ProfileDetailViewController") as! ProfileDetailViewController
        profileDetailVC.profileImageData = self.userDetailInfo["profileImage"] as? String
        self.present(profileDetailVC, animated: true) {
            print("profileDetailVC")
        }
    }
}

