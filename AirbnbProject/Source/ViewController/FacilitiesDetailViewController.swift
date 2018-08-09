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
        return 24
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
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesBoldLabelCell", for: indexPath) as! FacilitiesBoldLabelCell
            cell.boldLabel.text = "기본 편의시설"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "무선 인터넷"
            cell.twoLabel.text = "숙소 내에서 끊김없이 연결"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "실내 벽난로"
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "노트북 작업공간"
            cell.twoLabel.text = "노트북을 놓을 수 있는 책상이나 테이블과 편하게 앉아 일할 수 있는 의자"
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "필수품목"
            cell.twoLabel.text = "수건, 침대시트, 비누, 화장지"
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "난방"
            cell.twoLabel.text = "중앙 난방 또는 숙소 내 히터 비치"
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "온수"
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "다리미"
            return cell
        case 8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesBoldLabelCell", for: indexPath) as! FacilitiesBoldLabelCell
            cell.boldLabel.text = "가족용 시설"
            return cell
        case 9:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "어린이용 책과 장난감"
            return cell
        case 10:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "다기능/여행용 아기 침대"
            return cell
        case 11:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesBoldLabelCell", for: indexPath) as! FacilitiesBoldLabelCell
            cell.boldLabel.text = "시설"
            return cell
        case 12:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "건물 내 무료 주차"
            return cell
        case 13:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesBoldLabelCell", for: indexPath) as! FacilitiesBoldLabelCell
            cell.boldLabel.text = "조리 시설"
            return cell
        case 14:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "주방"
            cell.twoLabel.text = "게스트가 요리를 할 수 있는 공간"
            return cell
        case 15:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "아침식사"
            cell.twoLabel.text = "아침식사 제공"
            return cell
        case 16:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "커피메이커"
            return cell
        case 17:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "기본 조리 도구"
            cell.twoLabel.text = "냄비, 후라이팬, 기름, 소금, 후추"
            return cell
        case 18:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "식기류"
            return cell
        case 19:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "냉장고"
            return cell
        case 20:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesBoldLabelCell", for: indexPath) as! FacilitiesBoldLabelCell
            cell.boldLabel.text = "숙소에 없는 시설"
            return cell
        case 21:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "에어컨"
            cell.oneLabel.textColor = .gray
            return cell
        case 22:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesOneLineCell", for: indexPath) as! FacilitiesOneLineCell
            cell.oneLabel.text = "TV"
            cell.oneLabel.textColor = .gray
            return cell
        case 23:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesTwoLineCell", for: indexPath) as! FacilitiesTwoLineCell
            cell.oneLabel.text = "세탁기"
            cell.twoLabel.text = "건물 내, 유료 혹은 무료 이용 가능"
            cell.oneLabel.textColor = .gray
            cell.twoLabel.textColor = .gray
            return cell
        default:
            break
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImageCell", for: indexPath) as! swipeImageCell
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
