//
//  ExploringViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 30/07/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

import Alamofire
import Kingfisher

class ExploringViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var enterSearchBarTextField: UITextField!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var numberOfPeopleBtn: UIButton!
    
    var jsonPath = [String : Any]()
    
    let headerData: [Array<String>] = [
        ["Insu님, 무엇을 찾고 계신가요?", ""], ["에어비앤비 플러스를 만나보세요!", "퀄리티와 편안함이 검증된 새로운 숙소 컬렉션"],
        ["전 세계의 숙소",""], ["여행 목적에 딱 맞는 숙소", "원하시는 편의시설을 갖춘 최고 평점의 숙소를 찾아보세요"],
        ["최고 평점의 트립", "현지인과 전 세계 여행객에게서 높은 평가를 받은 트립"], ["인기 트립", ""],
        ["전 세계의 에어비엔비 플러스 서비스 지역", "내 집 같은 편안함 그 이상을 누릴 수 있는 아름다운 숙소를 확인해보세요"],
        ["슈퍼호스트의 숙소", "경험이 풍부한 호스트의 숙소에서 편안히 머물러보세요"], ["기억에 남을 독특한 숙소", "이색적인 숙소에 머무르며 조금 색다른 경험을 해보세요"],
        ["뉴욕의 트립", ""], ["뉴욕의 숙소", ""],
        ["바르셀로나의 트립", ""], ["바르셀로나의 숙소", ""],
        ["파리의 트립", ""], ["파리의 숙소", ""],
        ["도쿄의 트립", ""], ["도쿄의 숙소", ""],
        ["로스엔젤레스의 트립", ""], ["로스엔젤레스의 숙소", ""],
        ["리스본의 트립", ""], ["리스본의 숙소", ""],
        ["샌프란시스코의 트립", ""], ["샌프란시스코의 숙소", ""],
        ["시드니의 트립", ""], ["시드니의 숙소", ""],
        ["런던의 트립", ""], ["런던의 숙소", ""],
        ["로마의 트립", ""], ["로마의 숙소", ""]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designSetting()
        
        // CONNECT TO COLLECTION VIEW DELEGATE
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        // CONNECT TO TEXTFIELD DELEGATE
        
        enterSearchBarTextField.delegate = self
        
        // REGISTER COLLECTION VIEW CUSTOM CELL
        
        collectionView.register(UINib(nibName: "SuggestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCell")
        collectionView.register(UINib(nibName: "AirbnbPlusCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AirbnbPlusCell")
        collectionView.register(UINib(nibName: "HouseListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HouseListCell")
        collectionView.register(UINib(nibName: "HorizontalStyleCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalStyleCollectionCell")
        
        // REGISTER HEADER BY SECTION
        // Ref. CRV = Collection Reusable View
        
        collectionView.register(UINib(nibName: "TwoLineHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TwoLineHeaderCRV")
        
        // REGISTER FOOTER BY SECTION
        
        collectionView.register(UINib(nibName: "OneLineFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "OneLineFooterCollectionReusableView")
        
        // REGISTER NOTI FROM SELECTING NUMBER OF PEOPLE VIEW CONTROLLER
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(countInfo(noti:)) ,
            name: NSNotification.Name(rawValue: "getCountInfo"),
            object: nil
        )
        
        
        let jsonData = """
{
    "서울": [
        {
            "pk": 24,
            "rooms_host": 5,
            "rooms_type": "주택",
            "rooms_name": "[Open Discount]Cozy House. 2min Hongik Stn",
            "rooms_tag": "마포구",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:34:34.422067+09:00"
        },
        {
            "pk": 23,
            "rooms_host": 25,
            "rooms_type": "주택",
            "rooms_name": "1 min to subway, Clean Duplex Studio in Seoul",
            "rooms_tag": "Yangcheon-gu",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:34:24.827977+09:00"
        },
        {
            "pk": 22,
            "rooms_host": 24,
            "rooms_type": "주택",
            "rooms_name": "10mins to Gimpo airport by walk!/Gimpo Airport 1st",
            "rooms_tag": "강서구",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:34:06.828422+09:00"
        },
        {
            "pk": 20,
            "rooms_host": 22,
            "rooms_type": "주택",
            "rooms_name": "11 - Private cozy loft near Metro station",
            "rooms_tag": "Deungchon 1(il)-dong, Seoul",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:33:43.095488+09:00"
        },
        {
            "link": "https://leesoo.kr/rooms/list?address_city=서울"
        }
    ],
    "인천": [
        {
            "pk": 16,
            "rooms_host": 18,
            "rooms_type": "주택",
            "rooms_name": "★NEW★1min subway★Best location★Center of Incheon",
            "rooms_tag": "Bupyeong-gu",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:32:53.768900+09:00"
        },
        {
            "link": "https://leesoo.kr/rooms/list?address_city=인천"
        }
    ],
    "대구": [
        {
            "pk": 29,
            "rooms_host": 30,
            "rooms_type": "주택",
            "rooms_name": "Spacious Studio Great View 1 min. walk from Subway",
            "rooms_tag": "Dong-gu",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:35:41.093174+09:00"
        },
        {
            "pk": 28,
            "rooms_host": 29,
            "rooms_type": "주택",
            "rooms_name": "#동성로 Cosy and convenient House#2",
            "rooms_tag": "중구",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:35:31.695264+09:00"
        },
        {
            "pk": 27,
            "rooms_host": 28,
            "rooms_type": "주택",
            "rooms_name": "#1동대구역 도보4분~ 신세계백화점 앞1분♡로맨스하우스♡",
            "rooms_tag": "Dong-gu",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:35:23.852851+09:00"
        },
        {
            "pk": 26,
            "rooms_host": 27,
            "rooms_type": "주택",
            "rooms_name": "동대구역,신세계백화점 근처 *더 하우스* 복층:정남향:고층:야경:뷰좋아요 :)",
            "rooms_tag": "Dong-gu",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:35:13.137699+09:00"
        },
        {
            "link": "https://leesoo.kr/rooms/list?address_city=대구"
        }
    ],
    "부산": [
        {
            "pk": 37,
            "rooms_host": 38,
            "rooms_type": "주택",
            "rooms_name": "☆☆초고층, 오션뷰, 해운대 해수욕장 도보거리, 주차 & wifi 무료의 햇살가득한 집☆☆",
            "rooms_tag": "Haeundae",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T15:42:36.215737+09:00"
        },
        {
            "pk": 35,
            "rooms_host": 36,
            "rooms_type": "주택",
            "rooms_name": "Haeundae Beach 5mins, Metro 3mins!",
            "rooms_tag": "U 1(il)-dong",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:37:00.944909+09:00"
        },
        {
            "pk": 34,
            "rooms_host": 35,
            "rooms_type": "주택",
            "rooms_name": "광안역1min**광안리 해변7분# 위치좋은 넓고 깨끗한집, 집전체",
            "rooms_tag": "수영구",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:36:54.288136+09:00"
        },
        {
            "pk": 33,
            "rooms_host": 34,
            "rooms_type": "주택",
            "rooms_name": "#Ocean view#해운대해변 1분#7+MIPO Beach Studio",
            "rooms_tag": "해운대구",
            "days_price": 32800,
            "rooms_cover_thumbnail": "https://fc-airbnb-project.s3.amazonaws.com/media/CACHE/images/cover_image/rooms_cover_image/760b6c1888ecbf325ed359176ccbf3b3.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180816%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180816T074310Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ac0d02dc7f95354156565c4a6fb64f905d87091afb63b2b3d70a2b85b6f9a8e5",
            "created_at": "2018-08-16T14:36:43.805441+09:00"
        },
        {
            "link": "https://leesoo.kr/rooms/list?address_city=부산"
        }
    ]
}
"""
//        let data = jsonData.data(using: .utf8)!
//        do {
//            let json = try! JSONSerialization.jsonObject(with: data, options: [])
//
//            if let access = json as? [String : Any] {
//                print(access)
//                let accessPath = access["results"] as! [[String : Any]]
//
//                jsonPath = access
//
//                self.collectionView.reloadData()
//            }
//
//        } catch {
//            print("error")
//        }
        
    }
    
    @objc func countInfo(noti: Notification){
        print(noti)
    }
    
    private func designSetting() {
        
        // SET NUMBER OF PEOPLE BUTTON DESIGN
        
        let airbnbColor = UIColor(red: 0.047058823529412, green: 0.513725490196078, blue: 0.537254901960784, alpha: 1.0).cgColor
        self.numberOfPeopleBtn.layer.borderWidth = 0.1
        self.numberOfPeopleBtn.layer.borderColor = airbnbColor
        self.numberOfPeopleBtn.layer.cornerRadius = 2.0
        self.numberOfPeopleBtn.layer.masksToBounds = true
        
        // SET TEXTFILED DESIGN
        
        self.enterSearchBarTextField.layer.borderWidth = 0.2
        self.enterSearchBarTextField.layer.borderColor = UIColor.gray.cgColor
        self.enterSearchBarTextField.layer.cornerRadius = 2.0
        
        self.enterSearchBarTextField.layer.masksToBounds = false
        self.enterSearchBarTextField.layer.shadowColor = UIColor.gray.cgColor
        self.enterSearchBarTextField.layer.shadowOpacity = 0.3
        self.enterSearchBarTextField.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.enterSearchBarTextField.layer.shadowRadius = 4.0
        
        self.enterSearchBarTextField.attributedPlaceholder = NSAttributedString(string: "'코스타 트로피칼'에 가보는 건 어떠세요?", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.boldSystemFont(ofSize: 14.0)
            ])
    }
    
    
    @IBAction func showSubview(_ sender: UIButton) {
        let distributeGroupOfAgeVC = MoveStoryboard.toVC(storybardName: "Main", identifier: "DistributeGroupOfAgeViewController")
        
        distributeGroupOfAgeVC.modalPresentationStyle = .overCurrentContext
        present(distributeGroupOfAgeVC, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "getCountInfo"), object: nil)
        print("Noti Center is removed")
    }
    
}



extension ExploringViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    // MARK:- SET SECTION & ITEM NUMBER IN SECTION
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 29
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28 :
            return 4
        default:
            return 1
        }
        
        return 1
    }
    
    
    // MARK:- SET EACH CELL IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCollectionCell
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirbnbPlusCell", for: indexPath) as! AirbnbPlusCollectionCell
            return cell
            
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseListCell", for: indexPath) as! HouseListCollectionCell
            cell.delegate = self
            if let accessPath = self.jsonPath["results"] as? [[String : Any]] {
                cell.tagTitle.text = accessPath[indexPath.row]["rooms_tag"] as? String
                cell.houseTitle.text = accessPath[indexPath.row]["rooms_name"] as? String
                cell.priceNumberTitle.text = "\(accessPath[indexPath.row]["days_price"]!)"
                
                if let imagePath = accessPath[0]["room_images"] as? [[String:String]] {
                    let cellImageURL = URL(string: imagePath[0]["room_image_thumbnail"]!)!
                    print(cellImageURL)
                    print("Print : ", imagePath[indexPath.row]["room_image_thumbnail"]!)
                    cell.houseImage.kf.setImage(with: cellImageURL)
                }
            }
            
            return cell
            
        case 3, 5, 6, 8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalStyleCollectionCell", for: indexPath) as! HorizontalStyleCollectionCell
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }

    // MARK:- SET WIDTH & HEIGHT OF ITEM SIZE
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height / 3) //CGSize(width: self.collectionView.frame.width, height: 150)
        case 1:
            return CGSize(width: self.collectionView.frame.width, height: 250)
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
            return CGSize(width: self.collectionView.frame.width / 2 - 30, height: self.collectionView.frame.height / 2 - 30)
        case 3, 5, 6, 8:
            return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height / 2 + 100)
        default:
            return CGSize(width: 0, height: 0)
        }
        
        
    }
    
    
    //MARK:- SET HOUSE LIST COLLECTION CELL INSET
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:     // 숙소를 보여주는 컬렉션 뷰 셀의 경우에는 여기서 간격을 잡아준다.
            return UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0)
        default:
            return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        }
        
    }
    
    
    // MARK:- SET HEADER & FOOTER IN SECTION
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            switch indexPath.section {
            case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TwoLineHeaderCRV", for: indexPath) as! TwoLineHeaderCollectionReusableView
                header.twoLineHeaderTitle.text = headerData[indexPath.section][0]
                header.twoLineHeaderSubtitle.text = headerData[indexPath.section][1]
                return header
                
            default:
                return UICollectionReusableView()
            }
            
        case UICollectionElementKindSectionFooter:
            switch indexPath.section {
            case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:     // footer View 가 들어가야 하는 Section 을 여기에 추가.
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
                
                footer.delegate = self
//                if (self.jsonPath["count"] as? Int)! >= 2000 {
//                    
//                    footer.oneLineFooterBtn.setTitle("모두 보기(2000개 이상)", for: .normal)
//                } else {
//                    
//                    footer.oneLineFooterBtn.setTitle("모두 보기(\(self.jsonPath["count"] as! Int)개)", for: .normal)
//                }
                return footer
                
            default:    // footer View 가 들어가야 하는 Section 을 제외하고 모두 여기에 들어가게 된다.
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OneLineFooterCollectionReusableView", for: indexPath) as! OneLineFooterCollectionReusableView
                return footer
            }
            
        default:
            return UICollectionReusableView()
        }
        
        return UICollectionReusableView()
    }
    
    
    // MARK:- SET WIDTH, HEIGHT OF HEADER & FOOTER
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
            //        case 0, 2:
        //            return CGSize(width: self.collectionView.frame.width - 25, height: 40)
        case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:
            return CGSize(width: self.collectionView.frame.width - 25, height: 50)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 2, 4, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28:     // Footer View 의 Size 를 잡아주는 부분. Footer View를 넣고자 하는 경우, 위의 Case 와 동일하게 맞춰줘야 한다.
            return CGSize(width: self.collectionView.frame.width, height: 100)
        default:    // Footer View 를 없애고 싶은 경우.
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print("에어비앤비 플러스를 만나보세요 !")
        }
    }
    
    
}


// MARK:- SET UITEXTFIELD DELEGATE

extension ExploringViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enterSearchBarTextField.resignFirstResponder()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchBarViewController")
        present(vc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ExploringViewController: PresentVCDelegate {
    func presentVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveTestViewController")
        present(vc, animated: true)
        print("OK")
    }
}

extension ExploringViewController: PageStyleHoustListFooterDelegate {
    func presentShowEverythingVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowEverythingViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        print("Present ShowEverythingViewController")
    }
    
}
