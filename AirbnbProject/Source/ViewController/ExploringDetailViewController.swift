//
//  ExploringDetailViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 7. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class ExploringDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var moreTrip = false
    var moreText = false
    
    private struct Metric {
        // collectionView
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        
        static let numberOfItem: CGFloat = 2
        
        static let leftPadding: CGFloat = 10.0
        static let rightPadding: CGFloat = 10.0
        static let topPadding: CGFloat = 10.0
        static let bottomPadding: CGFloat = 10.0
    }
    
    var tripImages = UIImage(named: "views")
    var tripInfo = ["아파트 전체, 침대 1개", "아파트 전체, 침대 1개", "아파트 전체, 침대 3개", "아파트 전체, 침대 1개"]
    var tripName = ["Mouzinho 134 - Hist Center - Yellow", "Vitoria 392 - Central Loft", "Mouzinho 134 - Hist Center - Brown", "Lada River House - with fantastic RIVER VIEW!"]
    var tripPrice = ["87,055 /박", "129,933 /박", "116,940 /박", "10,000 /박"]
    var tripGrade = ["★★★★★ 111", "★★★★ 234", "★★★★★ 98", "★★★ 123"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.gray.cgColor
//        border.frame = CGRect(x: 0, y: collectionView.frame.size.height - width, width:  collectionView.frame.size.width, height: collectionView.frame.size.height)
//
//        border.borderWidth = width
//        collectionView.layer.addSublayer(border)
//        collectionView.layer.masksToBounds = true
        //register xib
        collectionView.register(
            UINib(nibName: "swipeImageCell", bundle: nil),
            forCellWithReuseIdentifier: "swipeImageCell"
        )
        
        collectionView.register(
            UINib(nibName: "HomeWhereCell", bundle: nil),
            forCellWithReuseIdentifier: "HomeWhereCell"
        )
        
        collectionView.register(
            UINib(nibName: "HostInfoCell", bundle: nil),
            forCellWithReuseIdentifier: "HostInfoCell"
        )
        
        collectionView.register(
            UINib(nibName: "HomeInfoCell", bundle: nil),
            forCellWithReuseIdentifier: "HomeInfoCell"
        )
        
        collectionView.register(
            UINib(nibName: "HomeDetailInfoCell", bundle: nil),
            forCellWithReuseIdentifier: "HomeDetailInfoCell"
        )
        
        collectionView.register(
            UINib(nibName: "BedRoomInfoCell", bundle: nil),
            forCellWithReuseIdentifier: "BedRoomInfoCell"
        )
        
        collectionView.register(
            UINib(nibName: "ExploringPublicCell", bundle: nil),
            forCellWithReuseIdentifier: "ExploringPublicCell"
        )
        
        collectionView.register(
            UINib(nibName: "FacilitiesCell", bundle: nil),
            forCellWithReuseIdentifier: "FacilitiesCell"
        )
        
        collectionView.register(
            UINib(nibName: "MapCell", bundle: nil),
            forCellWithReuseIdentifier: "MapCell"
        )
        
        collectionView.register(
            UINib(nibName: "ReviewCell", bundle: nil),
            forCellWithReuseIdentifier: "ReviewCell"
        )
        
        collectionView.register(
            UINib(nibName: "PerfectRefundCell", bundle: nil),
            forCellWithReuseIdentifier: "PerfectRefundCell"
        )
        
        collectionView.register(
            UINib(nibName: "PerfectPaymentCell", bundle: nil),
            forCellWithReuseIdentifier: "PerfectPaymentCell"
        )
        
        collectionView.register(
            UINib(nibName: "SimilarHome", bundle: nil),
            forCellWithReuseIdentifier: "SimilarHome"
        )
        
        collectionView.register(
            UINib(nibName: "PopularTrip", bundle: nil),
            forCellWithReuseIdentifier: "PopularTrip"
        )
        
        //header
        collectionView.register(UINib(nibName: "FirstHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FirstHeader")
        
        collectionView.register(UINib(nibName: "SecondHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SecondHeader")
        
        collectionView.register(UINib(nibName: "ThirdHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ThirdHeader")
        
        //footer
        collectionView.register(UINib(nibName: "FirstFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FirstFooter")
        
        collectionView.register(UINib(nibName: "ThirdFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "ThirdFooter")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//extension

extension ExploringDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        case 2:
            return 2
        case 3:
            return 9
        case 4:
            return 1
        case 5:
            if moreTrip == false {
                return 4
            }else {
                return 8
            }
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header: UICollectionReusableView
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3 {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstHeader", for: indexPath) as! FirstHeader
                header.isHidden = true
                return header
            }else if indexPath.section == 2 {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstHeader", for: indexPath) as! FirstHeader
                return header
            }else if indexPath.section == 4{
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SecondHeader", for: indexPath) as! SecondHeader
                return header
            }else {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThirdHeader", for: indexPath) as! ThirdHeader
                return header
            }
        case UICollectionElementKindSectionFooter:
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4 {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstFooter", for: indexPath) as! FirstFooter
                footer.isHidden = true
                return footer
            }else if indexPath.section == 2 {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstFooter", for: indexPath) as! FirstFooter
                footer.checkIn.text = "14:00 이후"
                footer.checkOut.text = "10:00"
                return footer
            }else {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThirdFooter", for: indexPath) as! ThirdFooter
                footer.delegate = self
                if moreTrip == true {
                    footer.isHidden = true
                }
                return footer
            }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 3 {
            return CGSize(width: self.collectionView.frame.width, height: 0)
        }else if section == 2 {
            return CGSize(width: self.collectionView.frame.width, height: 50)
        }else if section == 4{//section 5
            return CGSize(width: self.collectionView.frame.width, height: 60)
        }else {
            return CGSize(width: self.collectionView.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 3 || section == 4 {
            return CGSize(width: self.collectionView.frame.width, height: 0)
        }else if section == 2 {
            return CGSize(width: self.collectionView.frame.width, height: 100)
        }else {
            return CGSize(width: self.collectionView.frame.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == IndexPath(item: 3, section: 1) {
            moreText = true
            collectionView.reloadItems(at: [IndexPath(item: 3, section: 1)])
        }else if indexPath == IndexPath(item: 0, section: 2) {
            //편의시설
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let facilities = storyBoard.instantiateViewController(withIdentifier: "FacilitiesDetailViewController") as! FacilitiesDetailViewController
            self.present(facilities, animated: true)
        }else if indexPath == IndexPath(item: 1, section: 2) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mapViewController = storyBoard.instantiateViewController(withIdentifier: "HomeLocationViewController") as! HomeLocationViewController
            let mapCells = MapCell()
            mapViewController.maps = mapCells.latLon
//            self.navigationController?.pushViewController(mapViewController, animated: true)
            self.present(mapViewController, animated: true)
        }else if indexPath == IndexPath(item: 0, section: 3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let review = storyBoard.instantiateViewController(withIdentifier: "HomeReviewViewController") as! HomeReviewViewController
            self.present(review, animated: true)
        }
        print(indexPath)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImageCell", for: indexPath) as! swipeImageCell
                cell.delegate = self
                return cell
            default:
                break
            }
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeWhereCell", for: indexPath) as! HomeWhereCell
                
                cell.homeLocation.text = "섬"
                cell.homeTitle.text = "Private island in sunny Hvaler"
                
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostInfoCell", for: indexPath) as! HostInfoCell
                cell.hostLocation.text = "Vesteroy, Ostfold, 노르웨이"
                cell.hostName.text = "Cecille & Elvind님"
                cell.hostProfile.image = UIImage(named: "jin")
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeInfoCell", for: indexPath) as! HomeInfoCell
                cell.peopleCount.text = "5명"
                cell.roomCount.text = "원룸"
                cell.bedCount.text = "침대 2개"
                cell.washCount.text = "욕실 0개"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailInfoCell", for: indexPath) as! HomeDetailInfoCell
                
                cell.homeDetail.text = "When adding a collection view to your user interface, your app’s main job is to manage the data associated with that collection view. The collection view gets its data from the data source object, which is an object that conforms to the UICollectionViewDataSource Protocol and is provided by your app. Data in the collection view is organized into individual items, which can then be grouped into sections for presentation. An item is the smallest unit of data you want to present. For example, in a photos app, an item might be a single image. The collection view presents items onscreen using a cell, which is an instance of the UICollectionViewCell class that your data source configures and provides."
                var text = cell.homeDetail.text
                if moreText == false {
                    if (text?.count)! >= 200 {
                        cell.homeDetail.text = (text?.substring(to: (text?.index((text?.startIndex)!, offsetBy: 200))!))! + "...더보기"
                    }
                }
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BedRoomInfoCell", for: indexPath) as! BedRoomInfoCell
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 5:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "최소 1박"
                
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            default:
                break
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesCell", for: indexPath) as! FacilitiesCell
                var imageArr = ["wine", "kettle", "bed", "wash", "face", "airplane"]
                let imageViewArr = [cell.facImageView1, cell.facImageView2, cell.facImageView3, cell.facImageView4, cell.facImageView5]
                for i in 0..<5 {
                    imageViewArr[i]?.image = UIImage(named: imageArr[i])
                }
                cell.facCount.text = "\(imageArr.count - 5)"
                
                
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            default:
                break
            }
        }else if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                cell.reviewImageView.image = UIImage(named: "jin")
                cell.reviewName.text = "김승진"
                cell.reviewDate.text = "2018년 8월"
                cell.reviewMent.text = "When adding a collection view to your user interface, your app’s main job is to manage the data associated with that collection view. The collection view gets its data from the data source object, which is an object that conforms to the UICollectionViewDataSource Protocol and is provided by your app."
                var text = cell.reviewMent.text
                if (text?.count)! >= 100 {
                    cell.reviewMent.text = (text?.substring(to: (text?.index((text?.startIndex)!, offsetBy: 100))!))! + "...더보기"
                }
                cell.reviewCount.text = "후기 400개 읽기"
                cell.reviewGrade.text = "★★★★"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "숙소 이용규칙"
                
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "일반 환불 정책"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerfectRefundCell", for: indexPath) as! PerfectRefundCell
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "추가 요금"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 5:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "예약 가능일"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 6:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "호스트에게 연락하기"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 7:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerfectPaymentCell", for: indexPath) as! PerfectPaymentCell
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 8:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "신고하기"
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            default:
                break
            }
        }else if indexPath.section == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarHome", for: indexPath) as! SimilarHome
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularTrip", for: indexPath) as! PopularTrip
            cell.tripImageView.image = tripImages
            cell.tripInfo.text = tripInfo[indexPath.row]
            cell.tripName.text = tripName[indexPath.row]
            cell.tripPrice.text = tripPrice[indexPath.row]
            cell.tripGrade.text = tripGrade[indexPath.row]
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "swipeImageCell", for: indexPath) as! swipeImageCell
        return cell
    }
    
}

extension ExploringDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return CGSize(width: view.frame.width, height: 240)
            default:
                break
            }
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                return CGSize(width: view.frame.width, height: 130)
            case 1:
                return CGSize(width: view.frame.width, height: 110)
            case 2:
                return CGSize(width: view.frame.width, height: 150)
            case 3:
                if moreText == false {
                    return CGSize(width: view.frame.width, height: 160)
                }else {
                   return CGSize(width: view.frame.width, height: 400)
                }
            case 4:
                return CGSize(width: view.frame.width, height: 200)
            case 5:
                return CGSize(width: view.frame.width, height: 80)
            default:
                break
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
              return CGSize(width: view.frame.width, height: 65)
            case 1:
              return CGSize(width: view.frame.width, height: 370)
            default:
                break
            }
        }else if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                return CGSize(width: view.frame.width, height: 200)
            case 1:
                return CGSize(width: view.frame.width, height: 80)
            case 2, 4, 5, 6, 7, 8:
                return CGSize(width: view.frame.width, height: 80)
            case 3:
                return CGSize(width: view.frame.width, height: 100)
            default:
                break
            }
        }else if indexPath.section == 4 {
            return CGSize(width: view.frame.width, height: 300)
        }else {
            let totalSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
            let horizontalPadding = Metric.leftPadding + Metric.rightPadding
            let width = (collectionView.bounds.width - totalSpacing - horizontalPadding) / Metric.numberOfItem
            let height = width
            return CGSize(width: width, height: 200)
        }
        
        return CGSize(width: view.frame.width, height: 360)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return Metric.lineSpacing
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
        return Metric.itemSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
        ) -> UIEdgeInsets {
        return UIEdgeInsets(top: Metric.topPadding, left: Metric.leftPadding, bottom: Metric.bottomPadding, right: Metric.rightPadding)
    }
}

//delegate
extension ExploringDetailViewController: FooterDelegate {
    func FooterCell(_ itemCell: ThirdFooter, didTapAddButton: UIButton) {
        tripInfo = ["스파체험, 팜스프링스 사막", "스파체험, 팜스프링스 사막", "행글라이딩, 로스앤젤레스,", "사진촬영, 팜스프링스 사막", "스파체험, 팜스프링스 사막", "스파체험, 팜스프링스 사막", "행글라이딩, 로스앤젤레스,", "사진촬영, 팜스프링스 사막"]
        tripPrice = ["1인당 $63,375", "1인당 $63,375", "1인당 $328,397", "1인당 $86,420", "1인당 $63,375", "1인당 $63,375", "1인당 $328,397", "1인당 $86,420"]
        tripGrade = ["★★★★★", "★★★★★", "★★★★★", "★★★★", "★", "★★★★★", "★★★★★", "★★★★"]
        tripName = ["Hot Spring Sunset for Two", "Hot Spring Sanctuary for Two", "Hang Gliding", "Photoshoot & Adventure in Downtown", "Hot Spring Sunset for Two", "Hot Spring Sanctuary for Two", "Hang Gliding", "Photoshoot & Adventure in Downtown"]
        moreTrip = true
        let indexSet = IndexSet(integer: 5)
        self.collectionView.reloadSections(indexSet)
        
        print("ssibal")
    }
}
extension UIView {
    func addBorderTop(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    func addBorderBottom(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 10, y: frame.height - size, width: frame.width - 40, height: size, color: color)
    }
    func addBorderLeft(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    func addBorderRight(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    private func addBorderUtility(x x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = UIColor.gray.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}

extension ExploringDetailViewController: ImageViewDelegate {
    func ImageClick(_ itemCell: swipeImageCell, didTapAddButton: UIImageView) {
        let swipeCell = swipeImageCell()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailCell = storyBoard.instantiateViewController(withIdentifier: "HomeImageDetailViewController") as! HomeImageDetailViewController
        detailCell.homeImage = swipeCell.imageList
        self.present(detailCell, animated: true)
    }
}

