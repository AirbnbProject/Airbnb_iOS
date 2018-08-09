//
//  HorizontalStyleCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 01/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class HorizontalStyleCollectionCell: UICollectionViewCell {

    @IBOutlet weak var horizontalStyleCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        horizontalStyleCollectionView.dataSource = self
        horizontalStyleCollectionView.delegate = self
        
        horizontalStyleCollectionView.register(UINib(nibName: "NestedHorizontalStyleCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NestedHorizontalStyleCollectionCell")
    }

}

extension HorizontalStyleCollectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NestedHorizontalStyleCollectionCell", for: indexPath) as! NestedHorizontalStyleCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.horizontalStyleCollectionView.frame.width - 25, height: self.horizontalStyleCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}
