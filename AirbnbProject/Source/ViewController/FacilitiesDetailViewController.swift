//
//  FacilitiesDetailViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 8..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class FacilitiesDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var facilitiesList = ["주방", "무선 인터넷", "건조기", "헤어드라이어", "옷걸이", "필수품목"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //register xib
        collectionView.register(
            UINib(nibName: "FacilitiesBoldLabelCell", bundle: nil),
            forCellWithReuseIdentifier: "FacilitiesBoldLabelCell"
        )
        
        collectionView.register(
            UINib(nibName: "FacilitiesOneLineCell", bundle: nil),
            forCellWithReuseIdentifier: "FacilitiesOneLineCell"
        )
        
        collectionView.register(
            UINib(nibName: "FacilitiesTwoLineCell", bundle: nil),
            forCellWithReuseIdentifier: "FacilitiesTwoLineCell"
        )
        
        collectionView.register(
            UINib(nibName: "FacilitiesUnderLineCell", bundle: nil),
            forCellWithReuseIdentifier: "FacilitiesUnderLineCell"
        )
        
        //header
        collectionView.register(UINib(nibName: "FacilitiesHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FacilitiesHeader")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

//extension

extension FacilitiesDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return facilitiesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header: UICollectionReusableView
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FacilitiesHeader", for: indexPath) as! FacilitiesHeader
                return header
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: self.collectionView.frame.width, height: 100)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
        cell.oneLabel.text = facilitiesList[indexPath.row]
        return cell
    }
    
}

extension FacilitiesDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAt section: Int
//        ) -> CGFloat {
//        return Metric.lineSpacing
//    }
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAt section: Int
//        ) -> CGFloat {
//        return Metric.itemSpacing
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAt section: Int
//        ) -> UIEdgeInsets {
//        return UIEdgeInsets(top: Metric.topPadding, left: Metric.leftPadding, bottom: Metric.bottomPadding, right: Metric.rightPadding)
//    }
}
