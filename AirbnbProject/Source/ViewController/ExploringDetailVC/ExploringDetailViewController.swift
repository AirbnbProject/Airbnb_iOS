//
//  ExploringDetailViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 7. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import Kingfisher

class ExploringDetailViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let detailService: RoomDetailServiceType = RoomDetailService()
    
    var moreTrip = false
    var moreText = false
    var deliveriedPK = Int()
    var allInfo: [RoomDetail]? = []
    
    var pageNumber = CGFloat()
    
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
        settingInfo()
        self.navigationController?.navigationBar.isHidden = true
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
    
    @IBAction func goback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func settingInfo() {
        detailService.searchRoomDetailInfo(pk: deliveriedPK) { (result) in
            switch result {
            case .success(let value):
                print(value)
                self.allInfo = value
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contY = collectionView.contentOffset.y
        let index = IndexPath(item: 0, section: 0)
        let cells = collectionView.cellForItem(at: index)
        var cellY = cells?.frame.maxY
        guard cellY == nil else {
            if Float(contY) <= Float(cellY!) {
//                self.navigationController?.navigationBar.alpha = 0
                                self.navigationController?.isNavigationBarHidden = true
                backBtn.isHidden = false
            }else {
//                self.navigationController?.navigationBar.alpha = 1
                                self.navigationController?.isNavigationBarHidden = false
                backBtn.isHidden = true
            }
            return
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailCell = storyBoard.instantiateViewController(withIdentifier: "HomeImageDetailViewController") as! HomeImageDetailViewController
        guard (allInfo?.count)! > 0 else { return }
        var roomImages = allInfo![0].roomImages
        var imageArr = Array<String>()
        for i in 0..<(roomImages?.count)! {
            imageArr.append(roomImages![i]["room_image"] as! String)
        }
        detailCell.homeImage = imageArr
        self.present(detailCell, animated: true)
    }
    
    @objc func moveToNextPage() {
        guard (allInfo?.count)! > 0 else { return }
        var roomImages = allInfo![0].roomImages
        var imageArr = Array<String>()
        for i in 0..<(roomImages?.count)! {
            imageArr.append(roomImages![i]["room_image"] as! String)
        }
        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? swipeImageCell {
            let pageWidth:CGFloat = cell.scrollView.frame.width
            let maxWidth:CGFloat = pageWidth * 4
            let contentOffset:CGFloat = cell.scrollView.contentOffset.x
            
            var slideToX = contentOffset + pageWidth
            
            if  contentOffset + pageWidth == maxWidth
            {
                slideToX = 0
            }
            
            cell.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:cell.scrollView.frame.height), animated: true)
            var pageNumber = cell.scrollView.contentOffset.x / cell.scrollView.frame.size.width + 1
            print(pageNumber)
            if Int(pageNumber) < imageArr.count {
                cell.pageControl.currentPage = Int(pageNumber)
            }else {
                cell.pageControl.currentPage = 0
            }
        }
        
    }
}

//extension

extension ExploringDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5//return 6
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
//        case 5:
//            if moreTrip == false {
//                return 4
//            }else {
//                return 8
//            }
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header: UICollectionReusableView
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 2 {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstHeader", for: indexPath) as! FirstHeader
                header.isHidden = true
                //return header
            }else if indexPath.section == 4{
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SecondHeader", for: indexPath) as! SecondHeader
               // return header
            }else {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThirdHeader", for: indexPath) as! ThirdHeader
               // return header
            }
            
            return header
        case UICollectionElementKindSectionFooter:
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 4 {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstFooter", for: indexPath) as! FirstFooter
                footer.isHidden = true
                return footer
            }else if indexPath.section == 2 {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstFooter", for: indexPath) as! FirstFooter
                guard (allInfo?.count)! > 0 else { return footer}
                    let roomRule = allInfo![0].roomRules
                    var roomRuleArr = Array<String>()
                    for i in 0..<roomRule.count {
                        roomRuleArr.append(roomRule[i]["rule_list"] as! String)
                    }
                    footer.checkIn.text = "\(roomRuleArr[roomRuleArr.count - 3])"
                    footer.checkOut.text = "\(roomRuleArr[roomRuleArr.count - 2])"
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
        if section == 0 || section == 1 || section == 3 || section == 2 {
            return CGSize(width: self.collectionView.frame.width, height: 0)
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
        if indexPath == IndexPath(item: 0, section: 2) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "FacilitiesDetailViewController")
            self.present(new, animated: true)
        } else if indexPath == IndexPath(item: 1, section: 2) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mapViewController = storyBoard.instantiateViewController(withIdentifier: "HomeLocationViewController") as! HomeLocationViewController
            guard (allInfo?.count)! > 0 else { return }
                let roomLat = allInfo![0].addressLatitude
                let roomLon = allInfo![0].addressLongitude
                mapViewController.maps = [Double(roomLat)!, Double(roomLon)!]
            self.present(mapViewController, animated: true)
        }else if indexPath == IndexPath(item: 0, section: 3) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "HomeReviewViewController")
            self.present(new, animated: true)
        }else if indexPath == IndexPath(item: 1, section: 3){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let ruleViewController = storyBoard.instantiateViewController(withIdentifier: "HomeRuleViewController") as! HomeRuleViewController
            guard (allInfo?.count)! > 0 else { return }
                var roomRule = allInfo![0].roomRules
                var roomRuleArr = Array<String>()
                for i in 0..<roomRule.count {
                    roomRuleArr.append(roomRule[i]["rule_list"] as! String)
            }
            let roomHost = allInfo![0].roomsHost
            var hosts = roomHost.firstName
            ruleViewController.ruleLists = roomRuleArr
            ruleViewController.hostName = hosts
            self.present(ruleViewController, animated: true)
        }else if indexPath == IndexPath(item: 2, section: 3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let refundViewController = storyBoard.instantiateViewController(withIdentifier: "RefundViewController") as! RefundViewController
            guard (allInfo?.count)! > 0 else { return }
                let roomRefund = allInfo![0].refund
                refundViewController.refundRule = roomRefund
            self.present(refundViewController, animated: true)
        }else if indexPath == IndexPath(item: 4, section: 3) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "AddFeeViewController")
            self.present(new, animated: true)
        }else if indexPath == IndexPath(item: 8, section: 3) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "HomeReportViewController")
            self.present(new, animated: true)
        }else if indexPath == IndexPath(item: 3, section: 1) {
            moreText = true
            collectionView.reloadItems(at: [IndexPath(item: 3, section: 1)])
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
                guard (allInfo?.count)! > 0 else { return cell }
                var roomImages = allInfo![0].roomImages
                var imageArr = Array<String>()
                for i in 0..<(roomImages?.count)! {
                    imageArr.append(roomImages![i]["room_image"] as! String)
                }
                    cell.pageControl.numberOfPages = imageArr.count
                    var frame = CGRect(x:0, y:0, width:0, height:0)
                    for i in 0..<imageArr.count {
                        frame.origin.x = cell.scrollView.frame.size.width * CGFloat(i)
                        frame.size = cell.scrollView.frame.size
                        cell.imageView = UIImageView(frame: frame)
                        let url = URL(string: imageArr[i])
                        cell.imageView.kf.setImage(with: url)
                        cell.scrollView.addSubview(cell.imageView)
                        
                        cell.imageView.isUserInteractionEnabled = true
                        
                        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                        cell.imageView.isUserInteractionEnabled = true
                        cell.imageView.addGestureRecognizer(tapGestureRecognizer)
                        
                        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
                    }
                cell.scrollView.contentSize = CGSize(width: (cell.scrollView.frame.size.width * CGFloat(imageArr.count)), height: cell.scrollView.frame.size.height)
                cell.scrollView.delegate = self as? UIScrollViewDelegate
                cell.scrollView.isPagingEnabled = true
                
                return cell
            default:
                break
            }
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                var roomType = String()
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeWhereCell", for: indexPath) as! HomeWhereCell
                guard (allInfo?.count)! > 0 else { return cell }
                    cell.homeLocation.text = allInfo![0].roomsType
                    cell.homeTitle.text = allInfo![0].roomsName
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostInfoCell", for: indexPath) as! HostInfoCell
                guard (allInfo?.count)! > 0 else { return cell }
                
                    let roomHost = allInfo![0].roomsHost
                    let roomHostFirstName = roomHost.firstName
                    let roomHostProfileImage = roomHost.profileImage
                let url = URL(string: roomHostProfileImage)
                    //
                    cell.hostLocation.text = "\(allInfo![0].addressDistrict), \(allInfo![0].addressCity), \(allInfo![0].addressCountry)"
                    cell.hostName.text = roomHostFirstName
                    cell.hostProfile.kf.setImage(with: url)
                
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeInfoCell", for: indexPath) as! HomeInfoCell
                guard (allInfo?.count)! > 0 else { return cell }
                
                    cell.peopleCount.text = "\(allInfo![0].roomsPersonnel)명"
                    cell.roomCount.text = "방 \(allInfo![0].roomsAmount)개"
                    cell.bedCount.text = "침대 \(allInfo![0].roomsBed)개"
                    cell.washCount.text = "욕실 \(allInfo![0].roomsBathroom)개"
                
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailInfoCell", for: indexPath) as! HomeDetailInfoCell
                guard (allInfo?.count)! > 0 else { return cell }
                cell.homeDetail.text = allInfo![0].roomsDescription
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
                guard (allInfo?.count)! > 0 else { return cell }
                
                    cell.publicLabel.text = "최소 \(allInfo![0].checkInMinimum)박"
                
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            default:
                break
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploringPublicCell", for: indexPath) as! ExploringPublicCell
                cell.publicLabel.text = "편의시설"
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
                guard (allInfo?.count)! > 0 else { return cell }
                    let roomLat = allInfo![0].addressLatitude
                    let roomLon = allInfo![0].addressLongitude
                    cell.makeMap(lat: Double(roomLat)!, lon: Double(roomLon)!)//
                return cell
            default:
                break
            }
        }else if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                //
                let reviewCell = HomeReviewViewController()
                let reviewCount = reviewCell.reviewDates.count
                let reviewFirstMent = reviewCell.reviewMent
                let reviewFirstName = reviewCell.reviewNames[0]
                let reviewFirstDate = reviewCell.reviewDates[0]
                let reviewFirstProfile = reviewCell.reviewImages[0]
                //
                cell.reviewImageView.image = UIImage(named: reviewFirstProfile)
                cell.reviewName.text = reviewFirstName
                cell.reviewDate.text = reviewFirstDate
                cell.reviewMent.text = reviewFirstMent
                var text = cell.reviewMent.text
                if (text?.count)! >= 100 {
                    cell.reviewMent.text = (text?.substring(to: (text?.index((text?.startIndex)!, offsetBy: 100))!))! + "...더보기"
                }
                
                cell.reviewCount.text = "후기 \(reviewCount)개 읽기"
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
                return CGSize(width: view.frame.width, height: 80)
            case 2:
                return CGSize(width: view.frame.width, height: 130)
            case 3:
                if moreText == false {
                    return CGSize(width: view.frame.width, height: 200)
                }else {
                   return CGSize(width: view.frame.width, height: 400)
                }
            case 4:
                return CGSize(width: view.frame.width, height: 0)
            case 5:
                return CGSize(width: view.frame.width, height: 80)
            default:
                break
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
              return CGSize(width: view.frame.width, height: 50)
            case 1:
              return CGSize(width: view.frame.width, height: 370)
            default:
                break
            }
        }else if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                return CGSize(width: view.frame.width, height: 230)
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
        
    }
}

extension ExploringDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        guard (allInfo?.count)! > 0 else { return }
        var roomImages = allInfo![0].roomImages
        var imageArr = Array<String>()
        for i in 0..<(roomImages?.count)! {
            imageArr.append(roomImages![i]["room_image"] as! String)
        }
        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? swipeImageCell {
            if Int(pageNumber) < imageArr.count {
                cell.pageControl.currentPage = Int(pageNumber)
            }else {
                cell.pageControl.currentPage = 0
            }
        }
    }
}


