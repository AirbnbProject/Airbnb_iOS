//
//  SuggestionCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 31/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class SuggestionCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let suggestionTitleArray: Array<String> = ["숙소", "트립", "레스토랑"]
    let suggestionImageArray: Array<String> = ["suggestion_house", "suggestion_bike", "suggestion_restaurant",]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "NestedSuggestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NestedSuggestionCollectionCell")
    }

}


extension SuggestionCollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 셀을 배열로 묶어서 스위치 문으로 나눠 각각의 리턴을 주면 될 것 같은데?
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NestedSuggestionCollectionCell", for: indexPath) as! NestedSuggestionCollectionCell
        cell.suggestionTitle.text = suggestionTitleArray[indexPath.row]
        cell.suggestionImageView.image = UIImage(named: suggestionImageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width / 3 + 15 , height: self.collectionView.frame.height + 2)  //150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
