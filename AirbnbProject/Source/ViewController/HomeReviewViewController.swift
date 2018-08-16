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
    
    let reviewImages = ["jin", "cameras", "woman", "jin", "cameras", "woman", "jin", "cameras", "woman", "jin", "cameras", "woman", "jin", "cameras", "woman", "jin", "cameras", "woman" ]
    let reviewNames = ["김승진", "박인수", "엄태형", "김승진", "박인수", "엄태형", "김승진", "박인수", "엄태형", "김승진", "박인수", "엄태형", "김승진", "박인수", "엄태형", "김승진", "박인수", "엄태형"]
    let reviewDates = ["2018년 8월", "2018년 7월", "2017년 6월", "2018년 8월", "2018년 7월", "2017년 6월", "2018년 8월", "2018년 7월", "2017년 6월", "2018년 8월", "2018년 7월", "2017년 6월", "2018년 8월", "2018년 7월", "2017년 6월", "2018년 8월", "2018년 7월", "2017년 6월"]
    let reviewMent = "숙소가 좁고 좋네요~ 벌레도 나와서 친환경적이에요!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(nibName: "ReviewGradeCell", bundle: nil),
            forCellWithReuseIdentifier: "ReviewGradeCell"
        )
        
        collectionView.register(
            UINib(nibName: "ReviewListCell", bundle: nil),
            forCellWithReuseIdentifier: "ReviewListCell"
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
            return reviewDates.count
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
            cell.reviewCount.text = "후기 \(reviewImages.count)개"
            cell.addBorderBottom(size: 1.0, color: .gray)
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewListCell", for: indexPath) as! ReviewListCell
            cell.reviewProfile.image = UIImage(named: reviewImages[indexPath.row])
            cell.reviewName.text = reviewNames[indexPath.row]
            cell.reviewDate.text = reviewDates[indexPath.row]
            cell.reviewMent.text = reviewMent
            cell.addBorderBottom(size: 1.0, color: .gray)
            return cell
        } else {
            return UICollectionViewCell()
        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewGradeCell", for: indexPath) as! ReviewGradeCell
//        return cell
    }
    
}

extension HomeReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: 290)
        case 1:
            return CGSize(width: view.frame.width, height: 170)
        default:
            return CGSize(width: view.frame.width, height: 200)
        }
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
