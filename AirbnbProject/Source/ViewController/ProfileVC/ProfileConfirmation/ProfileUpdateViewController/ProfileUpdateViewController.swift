//
//  ProfileUpdateViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private enum Constraint {
    static let profileImageHeight: CGFloat = 250.0
    static let ProfileTextFieldCell: CGFloat = 95.0
    static let DetailUserInfoHeaderHeight: CGFloat = 60.0
}

var userDetailInfo: [String:Any] = [:]

class ProfileUpdateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var deliveriedImage = UIImage()
    
    var userDetailInfo: [String:Any] = [:]
    var pickerSelectInfo = ""
    let titleData = [["","이름","성"],
                     ["성별","생년월일","이메일"]]
    let sexInfo = ["남성","여성"]
    
    private let profileService: ProfileServiceType = ProfileService()
    private var activityView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialize()
        setupDatePicker()
        setupActivityIndicator()
        
        activityView.startAnimating()
        
        fetchProfile()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupInitialize() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.backgroundColor = .white
        self.saveButton.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 13)!], for: .normal)

    }
    
    private func setupNavigationBarItems() {
        
        let leftButton = UIButton(type: UIButtonType.custom)
        leftButton.setImage(UIImage(named: "close_black"), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let leftItem = UIBarButtonItem(customView: leftButton)
        navigationItem.setLeftBarButton(leftItem, animated: true)
        
        let updateButton = UIButton(type: UIButtonType.custom)
        updateButton.setAttributedTitle(NSAttributedString(string: "저장", attributes: [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 13)!]), for: .normal)
        updateButton.setTitleColor(.black, for: .normal)
        updateButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let rightItem = UIBarButtonItem(customView: updateButton)
        navigationItem.setRightBarButton(rightItem, animated: true)
        
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
    
    
    @objc private func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func updateProfileAction() {
        
    }

    
    @objc private func keyboardWillShow(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height
        self.tableViewHeight.constant = keyboardHeight

        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(noti: Notification) {
        
        let notiInfo = noti.userInfo! as Dictionary
        
        self.tableViewHeight.constant = 0
        UIView.animate(withDuration: notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupDatePicker() {
        
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: UIControlEvents.valueChanged)
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.tableView.reloadData()
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateProfile(_ sender: UIBarButtonItem) {
        self.activityView.startAnimating()
        
        profileService.patchProfile(token: UserDefaults.standard.string(forKey: "CurrentUserToken")!, profileImage: self.deliveriedImage, phoneNumber: "test", birthDay: "test", email: "test") { (result) in
                
                switch result {
                case .success(let userInfo):
                    self.activityView.stopAnimating()
                    
                    print(userInfo)
//                    self.userDetailInfo["profileImage"] = userInfo.profileImage
//                    self.userDetailInfo["phoneNumber"] = userInfo.phoneNumber
//                    self.userDetailInfo["birthday"] = userInfo.birthday
//                    self.userDetailInfo["firstName"] = userInfo.firstName
//                    self.userDetailInfo["lastName"] = userInfo.lastName
//                    self.tableView.reloadData()
                    
                    self.dismiss(animated: true, completion: nil)
                    
                case .failure(let error):
                    self.activityView.stopAnimating()
                    print(error)
                }
                
            }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.endEditing(true)
        tableView.reloadData()
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
                cell.title.text = titleData[indexPath.section][indexPath.row]
                cell.detailInfo.placeholder = "성별 선택"
                cell.detailInfo.inputView = pickerView
                cell.detailInfo.text = "남성"
                
                //백엔드에서 성별 빠짐
//                if let sex = self.userDetailInfo["gender"] as? String {
//                    cell.detailInfo.text = sex
//                }
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell
                cell.detailInfo.placeholder = "생일 선택"
                cell.detailInfo.inputView = datePicker
                if let birthday = self.userDetailInfo["birthday"] as? String {
                    cell.detailInfo.text = birthday
                }
                
                cell.title.text = titleData[indexPath.section][indexPath.row]
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextFieldCell", for: indexPath) as! ProfileTextFieldCell

                cell.detailInfo.text = self.userDetailInfo["email"] as? String
                if let email = self.userDetailInfo["email"] as? String {
                    cell.detailInfo.text = email
                }
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
    func profileImageDelivery(profileImage: UIImage) {
        self.deliveriedImage = profileImage
        print("set Image")
    }
    
    func presentViewController(viewController: UIViewController) {
        self.present(viewController, animated: true) {}
    }
}

extension ProfileUpdateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sexInfo.count
    }
}

extension ProfileUpdateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sexInfo[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerSelectInfo = sexInfo[row]
    }
}

