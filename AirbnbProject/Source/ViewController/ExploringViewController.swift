//
//  ExploringViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 30/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class ExploringViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var enterSearchBarTextField: UITextField!
    @IBOutlet weak var uiView: UIView!
    
    let headerData: [Array<String>] = [
        ["Insu님, 무엇을 찾고 계신가요?", ""],
        ["에어비앤비 플러스를 만나보세요!", "퀄리티와 편안함이 검증된 새로운 숙소 컬렉션"],
        ["전 세계의 숙소",""],
        ["여행 목적에 딱 맞는 숙소", "원하시는 편의시설을 갖춘 최고 평점의 숙소를 찾아보세요"],
        ["최고 평점의 트립", "현지인과 전 세계 여행객에게서 높은 평가를 받은 트립"],
        ["인기 트립", ""],
        ["전 세계의 에어비엔비 플러스 서비스 지역", "내 집 같은 편안함 그 이상을 누릴 수 있는 아름다운 숙소를 확인해보세요"],
        ["슈퍼호스트의 숙소", "경험이 풍부한 호스트의 숙소에서 편안히 머물러보세요"],
        ["기억에 남을 독특한 숙소", "이색적인 숙소에 머무르며 조금 색다른 경험을 해보세요"],
        ["뉴욕의 트립", ""],
        ["뉴욕의 숙소", ""],
        ["바르셀로나의 트립", ""],
        ["바르셀로나의 숙소", ""],
        ["파리의 트립", ""],
        ["파리의 숙소", ""],
        ["도쿄의 트립", ""],
        ["도쿄의 숙소", ""],
        ["로스엔젤레스의 트립", ""],
        ["로스엔젤레스의 숙소", ""],
        ["리스본의 트립", ""],
        ["리스본의 숙소", ""],
        ["샌프란시스코의 트립", ""],
        ["샌프란시스코의 숙소", ""],
        ["시드니의 트립", ""],
        ["시드니의 숙소", ""],
        ["런던의 트립", ""],
        ["런던의 숙소", ""],
        ["로마의 트립", ""],
        ["로마의 숙소", ""]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
        // CONNECT TO COLLECTION VIEW DELEGATE
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // REGISTER COLLECTION VIEW CUSTOM CELL
        
        collectionView.register(UINib(nibName: "SuggestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCell")
        collectionView.register(UINib(nibName: "AirbnbPlusCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AirbnbPlusCell")
        collectionView.register(UINib(nibName: "HouseListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HouseListCell")
        collectionView.register(UINib(nibName: "HorizontalStyleCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalStyleCollectionCell")
        
        // REGISTER HEADER BY SECTION
        // Ref. CRV = Collection Reusable View
        
        collectionView.register(UINib(nibName: "TwoLineHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoLineHeaderCRV")
        
        // REGiSTER FOOTER BY SECTION
        
        collectionView.register(UINib(nibName: "OneLineFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "OneLineFooterCollectionReusableView")
        
        
        // CONNECT TO TEXTFIELD DELEGATE
        enterSearchBarTextField.delegate = self
        
    }
    
}



extension ExploringViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK:- SET SECTION & ITEM NUMBER IN SECTION
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 29
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28 :
            return 4
        default:
            return 1
        }
        
        return 1
    }
    
    
    // MARK:- SET EACH CELL IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        
        switch indexPath.section {
        case 0:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCollectionCell
                return cell
            
        case 1:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirbnbPlusCell", for: indexPath) as! AirbnbPlusCollectionCell
                return cell
            
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseListCell", for: indexPath) as! HouseListCollectionCell
                return cell
            
        case 3, 5, 6, 8:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalStyleCollectionCell", for: indexPath) as! HorizontalStyleCollectionCell
                return cell
            
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    
    // MARK:- SET WIDTH & HEIGHT OF ITEM SIZE
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height / 3) //CGSize(width: self.collectionView.frame.width, height: 150)
        case 1:
            return CGSize(width: self.collectionView.frame.width, height: 250)
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
            return CGSize(width: self.collectionView.frame.width / 2 - 30, height: self.collectionView.frame.height / 2 - 30)
        case 3, 5, 6, 8:
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height / 2 + 100)
        default:
            return CGSize(width: 0, height: 0)
        }
        
        
    }
    
    
    //MARK:- SET HOUSE LIST COLLECTION CELL INSET
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:     // 숙소를 보여주는 컬렉션 뷰 셀의 경우에는 여기서 간격을 잡아준다.
            return UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0)
        default:
            return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        }
        
    }
    
    
    // MARK:- SET HEADER & FOOTER IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            switch indexPath.section {
            case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TwoLineHeaderCRV", for: indexPath) as! TwoLineHeaderCollectionReusableView
                header.twoLineHeaderTitle.text = headerData[indexPath.section][0]
                header.twoLineHeaderSubtitle.text = headerData[indexPath.section][1]
                
                
                return header
            default:
                return UICollectionReusableView()
            }
            
        case UICollectionElementKindSectionFooter:
            
            let footer: UICollectionReusableView
            switch indexPath.section {
            case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:     // footer View 가 들어가야 하는 Section 을 여기에 추가.
                footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
                return footer
            default:    // footer View 가 들어가야 하는 Section 을 제외하고 모두 여기에 들어가게 된다.
                footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
                return footer
            }
            
            
        default:
            return UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    
    // MARK:- SET WIDTH, HEIGHT OF HEADER & FOOTER
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
//        case 0, 2:
//            return CGSize(width: self.collectionView.frame.width - 25, height: 40)
        case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
            return CGSize(width: self.collectionView.frame.width - 25, height: 50)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:     // Footer View 의 Size 를 잡아주는 부분. Footer View를 넣고자 하는 경우, 위의 Case 와 동일하게 맞춰줘야 한다.
            return CGSize(width: self.collectionView.frame.width, height: 100)
        default:    // Footer View 를 없애고 싶은 경우.
            return CGSize(width: 0, height: 0)
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
