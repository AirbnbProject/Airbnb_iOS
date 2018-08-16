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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var moreTrip = false
    var moreText = false
    
    var allInfo = [[String: Any]]()
    
    var pageNumber = CGFloat()
    
    var exArr = ["https://cdn.namuwikiusercontent.com/s/2a2247cddcf5b21806e1bb3382807c571a94f1ef605491be5274cc8e8b225fa0f49614090b5783d81e6fb756433de0e650b34c56b3eb9efa2465f99a1aa47d222adac63136dad39bb5166024cfd5ab79?e=1540443520&k=fVEljU0mK6g-ZyGZlLOv5Q", "https://pbs.twimg.com/media/DauyuHdV4AEGiUo.jpg", "https://cdn.namuwikiusercontent.com/s/2a2247cddcf5b21806e1bb3382807c571a94f1ef605491be5274cc8e8b225fa0f49614090b5783d81e6fb756433de0e650b34c56b3eb9efa2465f99a1aa47d222adac63136dad39bb5166024cfd5ab79?e=1540443520&k=fVEljU0mK6g-ZyGZlLOv5Q", "https://pbs.twimg.com/media/DauyuHdV4AEGiUo.jpg"]
    
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
        
        
        
        let jsonData = """
    [
    {
        "pk": 6,
        "rooms_type": "OR",
        "rooms_name": "401-2 Cheap yet comfy stay in Seoul",
        "rooms_tag": "성북구",
        "rooms_host": {
            "first_name": "Taeyoung",
            "last_name": "",
            "profile_image": "https://fc-airbnb-project.s3.amazonaws.com/media/profile_image/profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=c770231c6fda46849bef358b126ccb717803db8f4957c7e900056138b187ab61",
            "phone_number": "01000000000",
            "birthday": "",
            "is_host": true,
            "create_date": "2018-08-14",
            "likes_posts": []
        },
        "rooms_cover_image": "https://fc-airbnb-project.s3.amazonaws.com/media/cover_image/rooms_cover_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=113c41f2a3cbd225d00909d2ae626011457b4719a7a0743a2999bfe5fc932629",
        "room_images": [
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            },
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            },
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            },
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            },
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            },
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            },
            {
                "room_image": "https://fc-airbnb-project.s3.amazonaws.com/media/room_profile_image/rooms_profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T074206Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=bbdd82b368c856a3226f287c129d2468cb53a4726503e63552eb9ae3bd124fc8"
            }
        ],
        "rooms_amount": 1,
        "rooms_bed": 1,
        "rooms_personnel": 2,
        "rooms_bathroom": 1,
        "days_price": 32800,
        "room_rules": [
            {
                "rule_list": "어린이(만 0-12세)에게 안전하거나 적합하지 않음"
            },
            {
                "rule_list": "흡연 금지"
            },
            {
                "rule_list": "반려동물 동반에 적합하지 않음"
            },
            {
                "rule_list": "파티나 이벤트 금지"
            },
            {
                "rule_list": "체크인 가능 시간: 14:00 이후"
            },
            {
                "rule_list": "체크아웃: 11:00까지"
            },
            {
                "rule_list": "키패드(으)로 셀프 체크인"
            }
        ],
        "room_facilities": [
            {
                "facilities": "주방"
            },
            {
                "facilities": "무선 인터넷"
            },
            {
                "facilities": "다리미"
            },
            {
                "facilities": "헤어드라이어"
            },
            {
                "facilities": "옷걸이"
            },
            {
                "facilities": "필수품목"
            }
        ],
        "rooms_description": "이 설명을 한국어로 번역하기",
        "check_in_minimum": 1,
        "check_in_maximum": 3,
        "room_reservations": [],
        "refund": "일반 정책 More information 체크인 5일 전까지 예약을 취소하면 에어비앤비 서비스 수수료을 제외한 요금이 환불됩니다.체크인까지 5일이 남지 않은 시점에 예약을 취소하면 첫 1박 요금과 나머지 숙박 요금의 50%는 환불되지 않습니다. 에어비앤비 서비스 수수료는 예약 후 48시간 이내에 취소하고 체크인 전인 경우에만 환불됩니다.",
        "address_country": "한국",
        "address_city": "서울",
        "address_district": "성북구",
        "address_detail": "Seongbuk",
        "address_latitude": "37.57956369609633",
        "address_longitude": "127.02012574408243",
        "created_at": "2018-08-14",
        "modified_date": "2018-08-14"
    }
    ]
    """
        
        let data = jsonData.data(using: .utf8)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
            let roomType = json[0]["rooms_type"] as! String
            let roomName = json[0]["rooms_name"] as! String
            let roomTag = json[0]["rooms_tag"] as! String
            let roomHost = json[0]["rooms_host"] as! [String: Any]
            let roomHostFirstName = roomHost["first_name"] as! String
//            let roomHostLastName = roomHost["Last_name"] as! String // null
            let roomHostProfileImage = roomHost["profile_image"] as! String
            let roomImages = json[0]["room_images"] as! [[String: Any]]
            var roomImageArr = Array<String>()
            for i in 0..<roomImages.count {
                roomImageArr.append(roomImages[i]["room_image"] as! String)
            }
            let roomAmount = json[0]["rooms_amount"] as! Int
            let roomBed = json[0]["rooms_bed"] as! Int
            let roomPerson = json[0]["rooms_personnel"] as! Int
            let roomBathroom = json[0]["rooms_bathroom"] as! Int
            let roomPrice = json[0]["days_price"] as! Int
            let roomRule = json[0]["room_rules"] as! [[String: Any]]
            var roomRuleArr = Array<String>()
            for i in 0..<roomRule.count {
                roomRuleArr.append(roomRule[i]["rule_list"] as! String)
            }
            let facilities = json[0]["room_facilities"] as! [[String: Any]]
            var facilitiesArr = Array<String>()
            for i in 0..<facilities.count {
               facilitiesArr.append(facilities[i]["facilities"] as! String)
            }
            let roomDescription = json[0]["rooms_description"] as! String
            let checkInMin = json[0]["check_in_minimum"] as! Int
            let checkInMax = json[0]["check_in_maximum"] as! Int
            let roomRefund = json[0]["refund"] as! String
            let roomLat = json[0]["address_latitude"] as! String
            let roomLon = json[0]["address_longitude"] as! String
            allInfo = json
            
        }catch {
            print("error")
        }
        
        collectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailCell = storyBoard.instantiateViewController(withIdentifier: "HomeImageDetailViewController") as! HomeImageDetailViewController
        detailCell.homeImage = exArr
        self.present(detailCell, animated: true)
    }
    
    @objc func moveToNextPage() {
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
            if Int(pageNumber) < exArr.count {
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
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 2 {
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FirstHeader", for: indexPath) as! FirstHeader
                header.isHidden = true
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
                //
                let roomRule = allInfo[0]["room_rules"] as! [[String: Any]]
                var roomRuleArr = Array<String>()
                for i in 0..<roomRule.count {
                    roomRuleArr.append(roomRule[i]["rule_list"] as! String)
                }
                //
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
        if indexPath == IndexPath(item: 0, section: 0) {
            print("fuxk you")
        }else if indexPath == IndexPath(item: 3, section: 1) {
            moreText = true
            collectionView.reloadItems(at: [IndexPath(item: 3, section: 1)])
        }else if indexPath == IndexPath(item: 0, section: 2) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "FacilitiesDetailViewController")
            self.present(new, animated: true)
        }else if indexPath == IndexPath(item: 1, section: 2) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mapViewController = storyBoard.instantiateViewController(withIdentifier: "HomeLocationViewController") as! HomeLocationViewController
            let roomLat = allInfo[0]["address_latitude"] as! String
            let roomLon = allInfo[0]["address_longitude"] as! String
            mapViewController.maps = [Double(roomLat)!, Double(roomLon)!]
            self.present(mapViewController, animated: true)
        }else if indexPath == IndexPath(item: 0, section: 3) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "HomeReviewViewController")
            self.present(new, animated: true)
        }else if indexPath == IndexPath(item: 1, section: 3){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let ruleViewController = storyBoard.instantiateViewController(withIdentifier: "HomeRuleViewController") as! HomeRuleViewController
            var roomRule = allInfo[0]["room_rules"] as! [[String: Any]]
            var roomRuleArr = Array<String>()
            for i in 0..<roomRule.count {
                roomRuleArr.append(roomRule[i]["rule_list"] as! String)
            }
            ruleViewController.ruleLists = roomRuleArr
            self.present(ruleViewController, animated: true)
        }else if indexPath == IndexPath(item: 2, section: 3) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let refundViewController = storyBoard.instantiateViewController(withIdentifier: "RefundViewController") as! RefundViewController
            let roomRefund = allInfo[0]["refund"] as! String
            refundViewController.refundRule = roomRefund
            self.present(refundViewController, animated: true)
        }else if indexPath == IndexPath(item: 4, section: 3) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "AddFeeViewController")
            self.present(new, animated: true)
        }else if indexPath == IndexPath(item: 8, section: 3) {
            let new = MoveStoryboard.toVC(storybardName: "Main", identifier: "HomeReportViewController")
            self.present(new, animated: true)
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
                let roomImages = allInfo[0]["room_images"] as! [[String: Any]]
                var roomImageArr = Array<String>()
                for i in 0..<roomImages.count {
                    roomImageArr.append(roomImages[i]["room_image"] as! String)
                }
                //
                cell.pageControl.numberOfPages = exArr.count
                var frame = CGRect(x:0, y:0, width:0, height:0)
                for i in 0..<exArr.count {
                    frame.origin.x = cell.scrollView.frame.size.width * CGFloat(i)
                    frame.size = cell.scrollView.frame.size
                    cell.imageView = UIImageView(frame: frame)
                    let url = URL(string: exArr[i])
                    cell.imageView.kf.setImage(with: url)
                    cell.scrollView.addSubview(cell.imageView)
                    
                    cell.imageView.isUserInteractionEnabled = true
                    
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                    cell.imageView.isUserInteractionEnabled = true
                    cell.imageView.addGestureRecognizer(tapGestureRecognizer)
                    
                    Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
                    //
                    
                    //
                }
                cell.scrollView.contentSize = CGSize(width: (cell.scrollView.frame.size.width * CGFloat(exArr.count)), height: cell.scrollView.frame.size.height)
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
                switch allInfo[0]["rooms_type"] as! String {
                case "OR":
                    roomType = "ONE ROOM"
                case "AP":
                    roomType = "APT"
                case "HO":
                    roomType = "HOUSING"
                case "GH":
                    roomType = "GUESTHOUSE"
                default:
                    break
                }
                cell.homeLocation.text = roomType
                cell.homeTitle.text = allInfo[0]["rooms_name"] as! String
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HostInfoCell", for: indexPath) as! HostInfoCell
                let roomHost = allInfo[0]["rooms_host"] as! [String: Any]
                let roomHostFirstName = roomHost["first_name"] as! String
                let roomHostProfileImage = roomHost["profile_image"] as! String
                let url = URL(string: roomHostProfileImage)
                //
                cell.hostLocation.text = allInfo[0]["rooms_tag"] as! String
                cell.hostName.text = roomHostFirstName
                cell.hostProfile.kf.setImage(with: url)
                cell.addBorderBottom(size: 1.0, color: .gray)
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeInfoCell", for: indexPath) as! HomeInfoCell
                cell.peopleCount.text = "\(allInfo[0]["rooms_personnel"] as! Int)명"
                cell.roomCount.text = "방 \(allInfo[0]["rooms_amount"] as! Int)개"
                cell.bedCount.text = "침대 \(allInfo[0]["rooms_bed"] as! Int)개"
                cell.washCount.text = "욕실 \(allInfo[0]["rooms_bathroom"] as! Int)개"
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
                cell.publicLabel.text = "최소 \(allInfo[0]["check_in_minimum"] as! Int)박"
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
                let roomLat = allInfo[0]["address_latitude"] as! String
                let roomLon = allInfo[0]["address_longitude"] as! String
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
        tripInfo = ["스파체험, 팜스프링스 사막", "스파체험, 팜스프링스 사막", "행글라이딩, 로스앤젤레스,", "사진촬영, 팜스프링스 사막", "스파체험, 팜스프링스 사막", "스파체험, 팜스프링스 사막", "행글라이딩, 로스앤젤레스,", "사진촬영, 팜스프링스 사막"]
        tripPrice = ["1인당 $63,375", "1인당 $63,375", "1인당 $328,397", "1인당 $86,420", "1인당 $63,375", "1인당 $63,375", "1인당 $328,397", "1인당 $86,420"]
        tripGrade = ["★★★★★", "★★★★★", "★★★★★", "★★★★", "★", "★★★★★", "★★★★★", "★★★★"]
        tripName = ["Hot Spring Sunset for Two", "Hot Spring Sanctuary for Two", "Hang Gliding", "Photoshoot & Adventure in Downtown", "Hot Spring Sunset for Two", "Hot Spring Sanctuary for Two", "Hang Gliding", "Photoshoot & Adventure in Downtown"]
        moreTrip = true
        let indexSet = IndexSet(integer: 5)
        self.collectionView.reloadSections(indexSet)
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

extension ExploringDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        print(pageNumber)

        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? swipeImageCell {
//            cell.pageControl.currentPage = Int(pageNumber)
            if Int(pageNumber) < exArr.count {
                cell.pageControl.currentPage = Int(pageNumber)
            }else {
                cell.pageControl.currentPage = 0
            }
        }
    }
}


