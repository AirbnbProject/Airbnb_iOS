//
//  ProfileUpdateViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

private enum Constraint {
    static let profileImageHeight: CGFloat = 250.0
    static let ProfileTextFieldCell: CGFloat = 95.0
    static let DetailUserInfoHeaderHeight: CGFloat = 60.0
}

class ProfileUpdateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var userDetailInfo: [String:Any] = [:]
    let titleData = [["","이름","성"],
                     ["성별","생년월일","이메일"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupInitialize() {

        tableView.dataSource = self
        tableView.delegate = self

        self.saveButton.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 13)!], for: .normal)

    }
    
    private func setupNavigationBarItems() {
        
        let leftButton = UIButton(type: UIButtonType.custom)
        leftButton.setImage(UIImage(named: "close_black"), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(backButtonAction), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftButton)
        navigationItem.setLeftBarButton(leftItem, animated: true)
        
        let updateButton = UIButton(type: UIButtonType.custom)
        updateButton.setAttributedTitle(NSAttributedString(string: "저장", attributes: [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 13)!]), for: .normal)
        updateButton.setTitleColor(.black, for: .normal)
        updateButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        updateButton.addTarget(self, action: #selector(updateProfileAction), for: UIControlEvents.touchUpInside)
        let rightItem = UIBarButtonItem(customView: updateButton)
        navigationItem.setRightBarButton(rightItem, animated: true)
        
    }
    
    @objc private func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func updateProfileAction() {
//        let profileUpdateVC = MoveStoryboard.toVC(storybardName: "Profile", identifier: "ProfileUpdateViewController") as! ProfileUpdateViewController
//        profileUpdateVC.userDetailInfo = userDetailInfo
//        present(profileUpdateVC, animated: true, completion: nil)
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ProfileUpdateViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return titleData[0].count
        case 1:
            return titleData[1].count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell

                cell.delegate = self // ProfileImageCellDelegate
                if let image = self.userDetailInfo["profileImage"] {
                    cell.profileImageView.kf.setImage(with: URL(string: image as! String), placeholder: UIImage(named: "profile"))
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell
                cell.title.text = titleData[indexPath.section][indexPath.row]
                cell.detailInfo.text = self.userDetailInfo["firstName"] as? String
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell
                cell.title.text = titleData[indexPath.section][indexPath.row]
                cell.detailInfo.text = self.userDetailInfo["lastName"] as? String
                return cell
                
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell
                cell.detailInfo.text = self.userDetailInfo["createDate"] as? String
                cell.title.text = titleData[indexPath.section][indexPath.row]
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell
                cell.detailInfo.text = self.userDetailInfo["createDate"] as? String
                cell.title.text = titleData[indexPath.section][indexPath.row]
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell
                cell.detailInfo.text = self.userDetailInfo["createDate"] as? String
                cell.title.text = titleData[indexPath.section][indexPath.row]
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = tableView.dequeueReusableCell(withIdentifier: "DetailUserInfoHeaderCell") as! DetailUserInfoHeaderCell
            return header
        }
        return UIView()
    }
}

extension ProfileUpdateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return Constraint.profileImageHeight
            default:
                return Constraint.ProfileTextFieldCell
            }
        case 1:
            switch indexPath.row {
            case 0,1,2:
                return Constraint.ProfileTextFieldCell
            default:
                return 0
            }
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return Constraint.DetailUserInfoHeaderHeight
        }
        
        return 0
    }
}


extension ProfileUpdateViewController: ProfileImageCellDelegate {
    func presentViewController(viewController: UIViewController) {
        self.present(viewController, animated: true) {}
    }
}














