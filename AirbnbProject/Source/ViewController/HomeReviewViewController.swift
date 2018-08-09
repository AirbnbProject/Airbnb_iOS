//
//  HomeReviewViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 9..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class HomeReviewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(nibName: "ReviewGradeCell", bundle: nil),
            forCellWithReuseIdentifier: "ReviewGradeCell"
        )
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

extension HomeReviewViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            break
        }
        return 1
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewGradeCell", for: indexPath) as! ReviewGradeCell
            cell.reviewCount.text = "씨발후기"
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewGradeCell", for: indexPath) as! ReviewGradeCell
        return cell
    }
    
}

extension HomeReviewViewController: UICollectionViewDelegateFlowLayout {
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
