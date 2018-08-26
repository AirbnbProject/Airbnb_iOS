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

    let homeImages = ["https://a0.muscache.com/im/pictures/4230043/7e9a64d3_original.jpg?aki_policy=xx_large","https://a0.muscache.com/im/pictures/66411338/d54f9bb4_original.jpg?aki_policy=xx_large","https://a0.muscache.com/im/pictures/6d17b555-d878-43e8-8c8b-bde4ee457591.jpg?aki_policy=xx_large","https://a0.muscache.com/im/pictures/b4066637-a13d-4a2f-801b-0d4d8551d719.jpg?aki_policy=xx_large"]
    let homeInfo = ["아파트 전체, 침대 1개", "아파트 전체, 침대 1개", "아파트 전체, 침대 3개", "아파트 전체, 침대 1개"]
    let homeName = ["(독채) 경복궁과 청와대 5분거리 리노베이션 한옥", "서귀포시 조용하고 한적한 시루네펜션^^(203호)", "#201 커플룸, 이호해수욕장, 공항근처", "Dwyane's luxury house (中文ok)"]
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
        return CGSize(width: 170, height: 250)
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
        cell.homeImageView.kf.setImage(with: URL(string: homeImages[indexPath.row]))
        cell.homeInfo.text = homeInfo[indexPath.row]
        cell.homeName.text = homeName[indexPath.row]
        cell.homePrice.text = homePrice[indexPath.row]
        cell.homeGrade.text = homeGrade[indexPath.row]
        return cell
    }
}
