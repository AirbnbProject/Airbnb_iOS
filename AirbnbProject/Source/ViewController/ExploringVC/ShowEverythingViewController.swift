//
//  ShowEverythingViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 15/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit
import Kingfisher

class ShowEverythingViewController: UIViewController {

    @IBOutlet weak var showEverythingCollectionView: UICollectionView!
    @IBOutlet weak var enterSearchBarTextField: UITextField!
    
    var regionName = ""                             // ExploringVC의 Footer를 선택했을 때 그에 대한 도시 구분 값이 여기로 넘어오게 된다.
    
    var totalJSONPath = [String : Any]()            // 통신을 통해 가져온 지역별 숙소 리스트를 담기 위한 딕셔너리
    var totalInKoreaJSONPath = [String : Any]()     // 통신을 통해 가져온 대한민국 전체의 숙소 리스트를 담기 위한 딕셔너리

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        // MARK:- TEXT FIELD
        
        enterSearchBarTextField.delegate = self
        
        showEverythingCollectionView.dataSource = self
        showEverythingCollectionView.delegate = self
        
        // MARK:- REGISTER COLLECTION VIEW CELL & HEADER
    
        showEverythingCollectionView.register(UINib(nibName: "SingleHouseListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SingleHouseListCollectionCell")
        showEverythingCollectionView.register(UINib(nibName: "TwoLineHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoLineHeaderCRV")
    
        // MARK:- UI DESIGN FUNCTION
        
        designSetting()
        
        // GET HOUSE LIST AFTER PUSH THIS VIEW CONTROLLER
        
        let roomTotalService = RoomService()
        
        if regionName != "" {
            // 각 도시의 지역에 대한 전체 숙소 리스트를 작업하는 부분
            roomTotalService.getTotalRoomList(region: regionName) { (result) in
                switch result {
                case .success(let value):
                    if let changeJSON = value as? [String: Any] {
                        self.totalJSONPath = changeJSON
//                        print("JSON BY REGION : ", self.totalJSONPath)
                        self.showEverythingCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
            print("region",regionName)
        
        } else {
            // 대한민국 지역 전체에 대한 숙소 리스트를 작업하는 부분
            roomTotalService.getTotalRoomListInKorea { (result) in
                switch result {
                case .success(let value):
                    if let changeJSON = value as? [String : Any] {
                        self.totalInKoreaJSONPath = changeJSON
//                        print("JSON IN KOREA : ", self.totalInKoreaJSONPath)
                        self.showEverythingCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    
//        if regionName == "서울" {
//            roomTotalService.getSearchResultByKeyword(inputKeyword: regionName) { (result) in
//                switch result {
//                case .success(let value):
//                    if let changeJSON = value as? [String : Any] {
//                        self.totalJSONPath = changeJSON
//                        self.dismiss(animated: true)
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//
//            self.showEverythingCollectionView.reloadData()
//
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let storyboard = UIStoryboard().instantiateViewController(withIdentifier: "SearchBarViewController") as! SearchBarViewController
//        self.regionName = storyboard.inputText
    }

    
    
    @IBAction func backBtnOnTextField(_ sender: UIButton) {
//        self.totalJSONPath = [:]
        self.navigationController?.popViewController(animated: true)
    }
    
    private func designSetting() {
        // SET TEXTFILED DESIGN
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
}

extension ShowEverythingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if regionName != "" {
            // 각 지역 별 숙소의 개수를 뿌려줄 부분.
            if let totalNumber = self.totalJSONPath["count"] as? Int {
//                print("totalNumber : ", totalNumber)
                return totalNumber
            }
        } else {
            // 대한민국 전체의 숙소의 개수를 뿌려줄 부분.
            if let totalNumberInKorea = self.totalInKoreaJSONPath["count"] as? Int {
//                print("totalNumberInKorea : ", totalNumberInKorea)
                return totalNumberInKorea
            }
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleHouseListCollectionCell", for: indexPath) as! SingleHouseListCollectionCell
        if regionName != "" {
            // regionName 으로 들어온 값을 기준으로 숙소 리스트 통신을 따로 받아 정의해주는 부분
            if let realTotalJSONPath = totalJSONPath["results"] as? [[String : Any]] {
                cell.typeTitle.text = realTotalJSONPath[indexPath.row]["rooms_type"] as? String
                cell.regionTitle.text = realTotalJSONPath[indexPath.row]["rooms_tag"] as? String
                cell.houseTitle.text = realTotalJSONPath[indexPath.row]["rooms_name"] as? String
                cell.priceTitle.text = "\(realTotalJSONPath[indexPath.row]["days_price"]!)"

                if let imagePath = realTotalJSONPath[indexPath.row]["rooms_cover_thumbnail"] as? String {
                    let cellImageURL = URL(string: imagePath)!
                    cell.SingleHouseListImageView.kf.setImage(with: cellImageURL)
                }
            }
        } else {
            // 대한민국의 숙소 리스트 통신을 따로 받아 정의해주는 부분
            if let realTotalInKoreaJSONPath = totalInKoreaJSONPath["results"] as? [[String : Any]] {
                cell.typeTitle.text = realTotalInKoreaJSONPath[indexPath.row]["rooms_type"] as? String
                cell.regionTitle.text = realTotalInKoreaJSONPath[indexPath.row]["rooms_tag"] as? String
                cell.houseTitle.text = realTotalInKoreaJSONPath[indexPath.row]["rooms_name"] as? String
                cell.priceTitle.text = "\(realTotalInKoreaJSONPath[indexPath.row]["days_price"]!)"
                if let imagePath = realTotalInKoreaJSONPath[indexPath.row]["rooms_cover_thumbnail"] as? String {
                    let cellImageURL = URL(string: imagePath)!
                    cell.SingleHouseListImageView.kf.setImage(with: cellImageURL)
                }
            }
        }
        return cell
    }
    
    // MARK:- SET WIDTH & HEIGHT OF ITEM SIZE
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: self.showEverythingCollectionView.frame.width, height: self.showEverythingCollectionView.frame.height / 2 + 90)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    
    // MARK:- SET HEADER & FOOTER IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TwoLineHeaderCRV", for: indexPath) as! TwoLineHeaderCollectionReusableView
                
                if let totalhouse = self.totalJSONPath["count"] as? Int {
                    header.twoLineHeaderTitle.text = "\(regionName) : \(totalhouse)개의 숙소를 확인해보세요!"
                } else if let totalhouseInKorea = self.totalInKoreaJSONPath["count"] as? Int {
                    header.twoLineHeaderTitle.text = "\(totalhouseInKorea)개의 숙소를 확인해보세요!"
                }
                
                header.twoLineHeaderSubtitle.text = ""
                return header
            default:
                return UICollectionReusableView()
            }
        default:
            return UICollectionReusableView()
        }
    }
    
    
    // MARK:- SET WIDTH, HEIGHT OF HEADER & FOOTER
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0:
            return CGSize(width: self.showEverythingCollectionView.frame.width - 25, height: 35)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExploringDetailViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

// MARK:- SET UITEXTFIELD DELEGATE

extension ShowEverythingViewController: UITextFieldDelegate {
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
