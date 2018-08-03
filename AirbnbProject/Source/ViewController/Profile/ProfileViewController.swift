//
//  ProfileViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 2..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

private enum Constraint {
    static let profileUpdateHeight: CGFloat = 150.0
    static let userInfoEnrollment: CGFloat = 200.0
    static let defaultOneLineCell: CGFloat = 80.0
}

class ProfileViewController: UIViewController {

    private let oneLineData = ["출장을 떠나시나요?","알림","친구를 초대하세요","여행 크레딧과 쿠폰","여행 크레딧과 쿠폰","설정","도움말","호스트가 되어보세요","피드백 남기기"]
    private let oneLineimage = ["arrow_right","bell","user-plus","user-plus","award","settings","ic_help_outline","home","edit"]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var testView: UIView!
    var lastContentOffset: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
        testView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupInitialize() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "DefaultOneLineCell", bundle: nil), forCellReuseIdentifier: "DefaultOneLineCell")
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
    
//    - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    _lastContentOffset = scrollView.contentOffset;
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView)
        
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("애니메이션")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print(decelerate)
        
        
        if (lastContentOffset?.y)! < scrollView.contentOffset.y
        {
            print("다운")
            if decelerate == true {
                self.testView.isHidden = true
                UIView.animate(withDuration: 1.0) {
                    self.testView.layoutIfNeeded()
                }
            }
            
        }
        else if (lastContentOffset?.y)! > scrollView.contentOffset.y
        {
            print("위")
            if decelerate == true {
                self.testView.isHidden = false
                UIView.animate(withDuration: 1.0) {
                    self.testView.layoutIfNeeded()
                }
            }
        }
    }
    

}


