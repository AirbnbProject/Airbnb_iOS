//
//  SimilarHome.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class SimilarHome: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private struct Metric {
        // collectionView
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        
        static let numberOfItem: CGFloat = 2
        
        static let leftPadding: CGFloat = 20.0
        static let rightPadding: CGFloat = 0.0
        static let topPadding: CGFloat = 0.0
        static let bottomPadding: CGFloat = 0.0
    }
    
    let homeImages = UIImage(named: "views")
    let homeInfo = ["아파트 전체, 침대 1개", "아파트 전체, 침대 1개", "아파트 전체, 침대 3개", "아파트 전체, 침대 1개"]
    let homeName = ["Mouzinho 134 - Hist Center - Yellow", "Vitoria 392 - Central Loft", "Mouzinho 134 - Hist Center - Brown", "Lada River House - with fantastic RIVER VIEW!"]
    let homePrice = ["87,055 /박", "129,933 /박", "116,940 /박", "10,000 /박"]
    let homeGrade = ["★★★★★ 111", "★★★★ 234", "★★★★★ 98", "★★★ 123"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "SimilarHomeCustomCell", bundle: nil),
            forCellWithReuseIdentifier: "SimilarHomeCustomCell"
        )
        collectionView.showsHorizontalScrollIndicator = false
    }

}

extension SimilarHome: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        return CGSize(width: 160, height: 250)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
        ) -> UIEdgeInsets {
        return UIEdgeInsets(top: Metric.topPadding, left: Metric.leftPadding, bottom: Metric.bottomPadding, right: Metric.rightPadding)
    }
}

extension SimilarHome: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return homeInfo.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarHomeCustomCell", for: indexPath) as! SimilarHomeCustomCell
        cell.homeImageView.image = homeImages
        cell.homeInfo.text = homeInfo[indexPath.row]
        cell.homeName.text = homeName[indexPath.row]
        cell.homePrice.text = homePrice[indexPath.row]
        cell.homeGrade.text = homeGrade[indexPath.row]
        return cell
    }
}
