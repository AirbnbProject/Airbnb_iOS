//
//  ShowEverythingViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 15/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class ShowEverythingViewController: UIViewController {

    @IBOutlet weak var showEverythingCollectionView: UICollectionView!
    @IBOutlet weak var enterSearchBarTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterSearchBarTextField.delegate = self
        
        showEverythingCollectionView.dataSource = self
        showEverythingCollectionView.delegate = self
        
        showEverythingCollectionView.register(UINib(nibName: "PageStyleHouseListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PageStyleHouseListCollectionCell")
        
        showEverythingCollectionView.register(UINib(nibName: "TwoLineHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoLineHeaderCRV")
        
        designSetting()
    }
    
    @IBAction func backBtnOnTextField(_ sender: UIButton) {
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageStyleHouseListCollectionCell", for: indexPath) as! PageStyleHouseListCollectionCell
        return cell
    }
    
    // MARK:- SET WIDTH & HEIGHT OF ITEM SIZE
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: self.showEverythingCollectionView.frame.width, height: self.showEverythingCollectionView.frame.height / 2) //CGSize(width: self.collectionView.frame.width, height: 150)
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
                header.twoLineHeaderTitle.text = "(300)여 개의 숙소를 모두 둘러보세요"
                header.twoLineHeaderSubtitle.text = ""
                return header
            default:
                return UICollectionReusableView()
            }
            
        case UICollectionElementKindSectionFooter:
            
            switch indexPath.section {
            case 0:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
                footer.oneLineFooterBtn.setTitle("", for: .normal)
                return footer
            default:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
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
        case 0:
            return CGSize(width: self.showEverythingCollectionView.frame.width - 25, height: 50)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 0:     // Footer View 의 Size 를 잡아주는 부분. Footer View를 넣고자 하는 경우, 위의 Case 와 동일하게 맞춰줘야 한다.
            return CGSize(width: 0, height: 0)
        default:    // Footer View 를 없애고 싶은 경우.
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("에어비앤비 플러스를 만나보세요 !")
        }
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
