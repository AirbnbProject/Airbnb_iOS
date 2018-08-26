//
//  SaveListViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 10/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class SaveListViewController: UIViewController {

    @IBOutlet weak var saveListCollectionView: UICollectionView!
    
    var saveListBasicCityNameArray: Array<String> = ["Malibu", "Los Angeles", "Cape Town", "Rotterdam", "London", "Lecce", "Vesteroy", "Vesteroy", "Santorini"]
    var saveListBasicImageNameArray: Array<String> = [
        "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic", "saveList_Basic"
    ]
    
    var saveListHeaderTitle: String = "저장 목록"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        saveListCollectionView.dataSource = self
        saveListCollectionView.delegate = self
        
        // REGISTER COLLECTION VIEW CUSTOM CELL
        saveListCollectionView.register(UINib(nibName: "SaveListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SaveListCollectionCell")
        
        
        // REGISTER HEADER BY SECTION
        // Ref. CRV = Collection Reusable View
        
        saveListCollectionView.register(UINib(nibName: "OneLineHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "OneLineHeaderCRV")
    }

}

extension SaveListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // IndexPath.row.Max = 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveListCollectionCell", for: indexPath) as! SaveListCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.saveListCollectionView.frame.width, height: self.saveListCollectionView.frame.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineHeaderCRV", for: indexPath) as! OneLineHeaderCollectionReusableView
            header.saveListOneLineHeaderTitle.text = saveListHeaderTitle
            return header
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.saveListCollectionView.frame.width - 25, height: 95)
    }
    
}
