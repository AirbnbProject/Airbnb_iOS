//
//  BedRoomInfoCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class BedRoomInfoCell: UICollectionViewCell {
    
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
    
    var roomList = ["1번 침실", "2번 침실", "공용 공간"]
    var roomDetails = ["킹사이즈 침대 1개", "더블 침대 1개", "소파 베드 2개"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "BedRoomInfoCollecionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "BedRoomInfoCollecionViewCell"
        )
        collectionView.showsHorizontalScrollIndicator = false
    }

}

extension BedRoomInfoCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        return CGSize(width: 150, height: 140)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
        ) -> UIEdgeInsets {
        return UIEdgeInsets(top: Metric.topPadding, left: Metric.leftPadding, bottom: Metric.bottomPadding, right: Metric.rightPadding)
    }
}

extension BedRoomInfoCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return roomList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BedRoomInfoCollecionViewCell", for: indexPath) as! BedRoomInfoCollecionViewCell
        cell.bedRoomName.text = roomList[indexPath.row]
        cell.bedRoomInfo.text = roomDetails[indexPath.row]
//        cell.addBorderTop(size: 1.0, color: .gray)
//        cell.addBorderBottom(size: 1.0, color: .gray)
//        cell.addBorderRight(size: 1.0, color: .gray)
//        cell.addBorderLeft(size: 1.0, color: .gray)
        return cell
    }
}
