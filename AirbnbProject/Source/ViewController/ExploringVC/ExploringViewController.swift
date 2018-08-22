//
//  ExploringViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 30/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

import Alamofire
import Kingfisher

class ExploringViewController: UIViewController {
    
    // MAIN VIEW CONTROLLER'S PROPERTY
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var enterSearchBarTextField: UITextField!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var numberOfPeopleBtn: UIButton!
    
    let headerData: [Array<String>] = [
        ["무엇을 찾고 계신가요?", ""], ["에어비앤비 플러스를 만나보세요!", "퀄리티와 편안함이 검증된 새로운 숙소 컬렉션"],
        ["대한민국의 숙소",""], ["서울의 숙소", ""], ["부산의 숙소", ""], ["대구의 숙소", ""],
        ["대전의 숙소", ""], ["강원도의 숙소", ""]
    ]
    
    let headerDataCityArray: [String] = ["서울", "부산", "대구", "대전", "강원도"]
    
    var totalJSONPath = [String : Any]()
    var totalJSONPathByKeyword: [String : Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Exploring VC viewDidLoad")
        
        designSetting()
        // CONNECT TO COLLECTION VIEW DELEGATE
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // CONNECT TO TEXTFIELD DELEGATE
        
        enterSearchBarTextField.delegate = self
        
        // REGISTER COLLECTION VIEW CUSTOM CELL
        
        collectionView.register(UINib(nibName: "SuggestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCell")
        collectionView.register(UINib(nibName: "AirbnbPlusCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AirbnbPlusCell")
        collectionView.register(UINib(nibName: "HouseListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HouseListCollectionCell")

        
        // REGISTER HEADER BY SECTION
        // Ref. CRV = Collection Reusable View
        
        collectionView.register(UINib(nibName: "TwoLineHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoLineHeaderCRV")
        
        // REGISTER FOOTER BY SECTION
        
        collectionView.register(UINib(nibName: "OneLineFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "OneLineFooterCollectionReusableView")
        
        // REGISTER NOTI FROM SELECTING NUMBER OF PEOPLE VIEW CONTROLLER
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(countInfo(noti:)) ,
            name: NSNotification.Name(rawValue: "getCountInfo"),
            object: nil
        )
        
        
        // MAIN VIEW CONTROLLER DATA EXCHANGE
        
        let roomservice = RoomService()
        
        roomservice.getRoomList { (result) in
            switch result {
            case .success(let value):
                //                print("value : ", value)
                if let changeJSON = value as? [String : Any] {
                    self.totalJSONPath = changeJSON
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @objc func countInfo(noti: Notification){
        print(noti)
    }
    
    // SET UI DESIGN OF EXPLORING VIEW CONTROLLER'S ELEMENTS : EXPLORING VIEW CONTROLLER 에 들어가는 각종 요소들의 디자인 설정
    private func designSetting() {
        
        // BUTTON 'NUMBER OF PEOPLE(인원)' DESIGN
//        let airbnbColor = UIColor(red: 0.047058823529412, green: 0.513725490196078, blue: 0.537254901960784, alpha: 1.0).cgColor
        self.numberOfPeopleBtn.layer.borderWidth = 0.1
//        self.numberOfPeopleBtn.layer.borderColor = airbnbColor
        self.numberOfPeopleBtn.layer.cornerRadius = 2.0
        self.numberOfPeopleBtn.layer.masksToBounds = true
        
        // TEXTFILED 'SEARCH BAR(검색 창)' DESIGN
        self.enterSearchBarTextField.layer.borderWidth = 0.2
        self.enterSearchBarTextField.layer.borderColor = UIColor.gray.cgColor
        self.enterSearchBarTextField.layer.cornerRadius = 2.0
        
        self.enterSearchBarTextField.layer.masksToBounds = false
        self.enterSearchBarTextField.layer.shadowColor = UIColor.gray.cgColor
        self.enterSearchBarTextField.layer.shadowOpacity = 0.3
        self.enterSearchBarTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.enterSearchBarTextField.layer.shadowRadius = 4.0
        
        self.enterSearchBarTextField.attributedPlaceholder = NSAttributedString(string: "'코스타 트로피칼'에 가보는 건 어떠세요?", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.boldSystemFont(ofSize: 14.0)
            ])
    }

    // FUNCTION : SHOW DISTRIBUTE GROUP OF AGE VIEW CONTROLLER OF SUBVIEW STYLE AFTER CLICK NUMBER OF PEOPLE BUTTON
    @IBAction func showSubview(_ sender: UIButton) {
        let distributeGroupOfAgeVC = MoveStoryboard.toVC(storybardName: "Main", identifier: "DistributeGroupOfAgeViewController")
        distributeGroupOfAgeVC.modalPresentationStyle = .overCurrentContext
        present(distributeGroupOfAgeVC, animated: true, completion: nil)
    }
    
    
    
    // DEINIT : TURN OFF NOTIFICATION CENTER
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "getCountInfo"), object: nil)
        print("Noti Center is removed")
    }
    
}


// EXTENSION : BASIC SETTING OF MAIN COLLECTION VIEW

extension ExploringViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK:- SET SECTION & ITEM NUMBERS IN SECTION
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.headerData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0,1 :
            return 1
        default :
            return 4
        }
    }
    
    
    // MARK:- SET EACH CELL IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let randomNumberForRow = arc4random_uniform(3)
        let randomNumberForSection = arc4random_uniform(UInt32(headerDataCityArray.count - 1)) // ***** 계속 반복해서 실행되지 않도록 전역으로 빼야함 *****
        let randomCount = arc4random_uniform(1234)
        
        switch indexPath.section  {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCollectionCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirbnbPlusCell", for: indexPath) as! AirbnbPlusCollectionCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseListCollectionCell", for: indexPath) as! HouseListCollectionCell
            cell.delegate = self
            
            if let secondChangeJSON = self.totalJSONPath[headerDataCityArray[Int(randomNumberForSection)]] as? [[String:Any]] {
                cell.typeTitle.text = secondChangeJSON[indexPath.row]["rooms_type"] as? String
                cell.tagTitle.text = secondChangeJSON[indexPath.row]["rooms_tag"] as? String
                cell.houseTitle.text = secondChangeJSON[indexPath.row]["rooms_name"] as? String
                cell.priceNumberTitle.text = "\(secondChangeJSON[indexPath.row]["days_price"]!)"
                cell.participationCountTitle.text = "\(Int(randomCount))"
                
                if let imagePath = secondChangeJSON[indexPath.row]["rooms_cover_thumbnail"] as? String {
                    let cellImageURL = URL(string: imagePath)!
                    cell.houseImage.kf.setImage(with: cellImageURL)
                }
            }
            
            return cell
        default: // Case 3 ~ 12, Total Count : 13
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseListCollectionCell", for: indexPath) as! HouseListCollectionCell
            cell.delegate = self
        
            if let secondChangeJSON = self.totalJSONPath[headerDataCityArray[indexPath.section - 3]] as? [[String:Any]] {
                cell.typeTitle.text = secondChangeJSON[indexPath.row]["rooms_type"] as? String
                cell.tagTitle.text = secondChangeJSON[indexPath.row]["rooms_tag"] as? String
                cell.houseTitle.text = secondChangeJSON[indexPath.row]["rooms_name"] as? String
                cell.priceNumberTitle.text = "\(secondChangeJSON[indexPath.row]["days_price"]!)"
                cell.participationCountTitle.text = "\(Int(randomCount))"
                
                if let imagePath = secondChangeJSON[indexPath.row]["rooms_cover_thumbnail"] as? String {
                    let cellImageURL = URL(string: imagePath)!
                    cell.houseImage.kf.setImage(with: cellImageURL)
                }
                
            }
            return cell
        }
    }

    
    // MARK:- SET WIDTH & HEIGHT OF ITEM SIZE
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: self.collectionView.frame.width, height: 180) //CGSize(width: self.collectionView.frame.width, height: 150)
        case 1:
            return CGSize(width: self.collectionView.frame.width, height: 250)
        default:
            return CGSize(width: self.collectionView.frame.width / 2 - 30, height: self.collectionView.frame.height / 2 - 30)
        }
        
        
    }
    
    
    //MARK:- SET HOUSE LIST COLLECTION CELL INSET
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 0, 1 :
            return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        default:    // 숙소를 보여주는 컬렉션 뷰 셀의 경우에는 여기서 간격을 잡아준다.
            return UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0)
        }
        
    }
    
    
    // MARK:- SET HEADER & FOOTER IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            switch indexPath.section {
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TwoLineHeaderCRV", for: indexPath) as! TwoLineHeaderCollectionReusableView
                header.twoLineHeaderTitle.text = headerData[indexPath.section][0]
                header.twoLineHeaderSubtitle.text = headerData[indexPath.section][1]
                return header
            }
            
            
        case UICollectionElementKindSectionFooter:
            switch indexPath.section {
            default:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
                
                footer.delegate = self
                footer.tag = indexPath.section
               
                // 서울 + 부산 + 대구 + 대전 + 강원도 = 대한민국
//
//                footer.oneLineFooterBtn.setTitle("모두 보기(2000개 이상)", for: .normal)
//                                if (self.totalJSONPath["count"] as? Int)! >= 2000 {
//
//                                    footer.oneLineFooterBtn.setTitle("모두 보기(2000개 이상)", for: .normal)
//                                } else {
//
//
//                                    footer.oneLineFooterBtn.setTitle("모두 보기(\(self.totalJSONPath["count"] as! Int)개)", for: .normal)
//                                }
                return footer
            }
            
        default:
            return UICollectionReusableView()
        }
        
        
    }
    
    
    // MARK:- SET WIDTH, HEIGHT OF HEADER & FOOTER
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        default:
            return CGSize(width: self.collectionView.frame.width - 25, height: 50)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 0, 1:
            // Footer View 를 없애고 싶은 경우.
            return CGSize(width: 0, height: 0)
        default:
            // Footer View 의 Size 를 잡아주는 부분. Footer View를 넣고자 하는 경우, 위의 Case 와 동일하게 맞춰줘야 한다.
            return CGSize(width: self.collectionView.frame.width, height: 100)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print("에어비앤비 플러스를 만나보세요 !")
        }
    }
    
    
}

// MARK:- SET UITEXTFIELD DELEGATE

extension ExploringViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        enterSearchBarTextField.resignFirstResponder()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchBarViewController")
        present(vc, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

}

// DELEGATE TEST SECTION

extension ExploringViewController: PresentVCDelegate {
    func presentVC() {
        print("OK")
    }
}

// SHOW EVERYTHING VIEW CONTROLLER AFTER CLICK FOOTER BUTTON BY USING PUSH

extension ExploringViewController: OneLineFooterDelegate {
    func pushShowEverythingVC(footerView: UICollectionReusableView) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowEverythingViewController") as! ShowEverythingViewController
        
        if footerView.tag == 2 {
            vc.regionName = ""
        } else if footerView.tag == 3 {
            vc.regionName = "서울"
        } else if footerView.tag == 4 {
            vc.regionName = "부산"
        } else if footerView.tag == 5 {
            vc.regionName = "대구"
        } else if footerView.tag == 6 {
            vc.regionName = "대전"
        } else if footerView.tag == 6 {
            vc.regionName = "강원도"
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        print("Present ShowEverythingViewController")
    }
}
