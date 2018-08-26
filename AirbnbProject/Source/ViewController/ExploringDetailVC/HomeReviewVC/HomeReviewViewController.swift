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
    
    let reviewImages = ["https://a0.muscache.com/im/pictures/user/0300432b-9220-4026-b061-02e4edbc377d.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/68a12722-371c-4ed3-93f2-1e9a509b1c23.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/21491896-d153-4ac2-9261-6267eff9b40e.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/e018288d-5f9e-41c6-99e8-33b327079942.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/192b34bb-6136-4dba-bf25-3e5c8e2368bb.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/807ae184-d57f-4dcb-8ff4-330bc892b796.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/920a3df5-231f-4ea3-9eb4-e883c2e0b85d.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/ae385162-30d0-4cf1-96ba-1c5a85ef7045.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/ae385162-30d0-4cf1-96ba-1c5a85ef7045.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/403a1e42-0097-4a27-bddf-e3f737e2943a.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/9b285a5f-d80e-402e-8031-5756d9934e07.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/users/19896390/profile_pic/1416743627/original.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/e126672f-33ea-45a7-920f-4a291cb73ad8.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/8e615b2c-1c2c-4f66-9377-de1d02f6bf54.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/afee7888-e040-47c3-a818-5924ffb0c7cd.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/0d6264b5-a1bf-49f5-ab8a-bb04e4c5a2ef.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/45cbaa09-de38-434b-91b0-6f183478044a.jpg?aki_policy=profile_x_medium", "https://a0.muscache.com/im/pictures/user/f7536bdc-d0dc-447a-90c7-78dd59312f22.jpg?aki_policy=profile_x_medium"]
    let reviewNames = ["인대", "병재", "JooHyun", "대", "Arielle", "Kim", "Young Chang", "Tae Kyu", "Hyun Jung", "지현", "건", "우량", "Woochang", "Yebin", "Yaerim", "Hyungil", "지혜", "Seokmin" ]
    let reviewDates = ["2018년 8월", "2018년 8월", "2017년 6월", "2018년 5월", "2018년 5월", "2018년 5월", "2018년 4월", "2018년 3월", "2018년 3월", "2018년 3월", "2018년 2월", "2018년 2월", "2018년 2월", "2018년 1월", "2017년 1월", "2018년 1월", "2018년 1월", "2017년 12월"]
    let reviewMent = ["위치적으로도 조용하고 숙소의 뷰가 좋아서 매일 아침 기분좋게 시작할 수 있었습니다,, 호스트분도 너무나 친절했고 조식도 훌륭했어요!! 저는 특히나 청결에 민감한데 아주 좋았습니다 서귀포쪽으로 숙소를 잡으시는분에게 아주 강추해요!!","가는 날 사람이 많이 없어 숙소 업그레이드도 해주시고 저렴한 가격에 바다뷰에 복층 숙소에서 잘 수 있어서 너무 좋았습니다. 주변에 맛집소개도 해주시고 정말 잘 쉬다가 갑니다.","경치 조식 청결도 호스팅 모두다 좋았습니다. 편안하게 쉬다갑니다","모든것이 완벽했던 숙소입니다. 주변 조용한 분위기에 여행가서 힐링하기 좋은 위치였습니다. 무엇보다도 호스트분께서 너무너무 친절하셨고 인상이 좋았습니다. 숙소에 들어간 순간 향기가 너무 좋았고 공기청정기까지 비치된 모습이 좋았습니다. 거기다가 바다가 보이는 뷰까지...산책로도 잘되있더군요! 깨끗한 숙소와 관광나가서 숙소 비울 때 정리까지 해주시고 숙소에 머무는 동안 기분이 너무 좋았네요. 조식도 준비해주시는데 못먹은게 너무 아쉽습니다. 다음에 또 제주에 갈텐데 다시 꼭 들릴 숙소입니다. 잘 묵다갑니다 감사합니다~^^^","잘쉬다가 갑니다^^","정말 좋았습니다. 모든 시설이 있었으며 장기적으로 머물기에도 무지 좋은 숙소입니다. 조식은 어느 호텔의 조식에 지지않을만큼 맛있었고 호스트님의 정보들 덕분에 정말 재미있게 잘 놀다왔습니다. 에어비엔비를 4번째 사용하는데 역대급 숙소였다고 자부합니다. 다음에 또 제주에간다면 주저없이 이 숙소를 예약할 것입니다.","큰 창으로 보이는 바다와 바람에 사락거리는 나무들을 바라보는것만으로도 완벽한 쉼이 될 수 있는 아주 훌륭한 공간입니다. 늦잠을 잔 저희에게 아침식사도 직접 가져다주셔서 너무 좋았습니다. 날이 더워지면 야외 바비큐먹으러 꼭 가야겠어요:D","한적한 곳에 있어서 조용하긴해요 이제껏 다녔던 여행중에 조식은 최고~ 여행자는 체크아웃시간에 쪼들려서 조식 만들어먹고 설겆이하고 시간이 촉박해서 조식안먹고 나올때가 많았는데 여기는 미리 준비해서 다 내어주시더라구요. 친철도는 매우 좋았습니다. 다만 제습기 사용을 해도 공기가 습하긴 합니다 ^^;","개인이 하는 숙소인줄 알았는데 펜션이더라고요. 쪽지 요청은 답 받는데 몇시간씩 텀이 있긴 하지만 전화드리면 바로 연락 받으십니다. 숙소는 깔끔하긴한데 그냥 중저가 펜션 정도로 기대하시고 가면 될 것 같아요. 가구나 벽지 같은게 오래된 느낌이었습니다.","최고의 숙소였습니다!","주인장의 정성이 물씬 묻어나는 공간이었어요. 특히 아침 조식은, 매우 기분좋게 하루를 시작하게 해주는 힘... 기분좋게 아침을 시작하고 싶은 분들이라면 이 숙소는, 꽤 괜찮은 공간이랍니다.~","처음 맞이해주신 순간 부터 나가는 순간 까지 정말 친절히 잘 안내해 주셔서 마음 편하게 잘 머물고 갑니다. 추천해 주신 횟집도 너무너무 맛있었구요. 귤 따기 체험도 너무나 재미있었습니다. 덕분에 다음 날 간식이 든든 ㅎㅎ 숙소도 아늑하고 깔끔했고 조식마저 맛있더라구요. 정말 적극 추천합니다!","너무너무 좋았어요 에어비앤비 사용하면서 이렇게 친절한 호스트분은 처음 봤어요 다들 친절하신 편이지만 여기는 특히 더 그래서 가족끼리 이용하기 너무 좋을 것 같아요 엄마도 만족하셨구요 감귤따는 체험도 좋았고 뷰도 좋았구여 산책로도, 조식도 너무 훌륭했어요","펜션이름대로 정말 잘 머물다가 가요 도착해서부터 갈때까지 정말 좋았어요 숙소도 깨끗하고 경치도 좋구 편의점도 가깝고 조식도 맛잇어서 깜짝 놀랄정도였어요👍 담에 또 놀러올게요","조식도 맛있고 산책로도 훌륭했어요. 무엇보다 방이 청결해서 넘 좋았어요","숙소 뷰가 가장 마음에 들었고 위치도 인근에 숨은 맛집이나 편의점도 많아서 좋았습니다. 조식도 깔끔했고 시설도 청결했어요. 특히 숙박비 대비 만족도가 높았던 것 같습니다. 다음에 또 찾을게요 :D","아이와 단둘이 여행이었는데 숙소, 주변환경, 펜션내 놀이시설들, 조식, 위치 모든것이 맞춤처럼 좋았습니다.^^","위치 산책로 방 상태 모든게 좋았어요 특히 조식이 대박이고요 다음에 무조건 재방문입니다","사장님이 정말친절하시고좋았어요 잘쉬다갑니다","일단 굉장히 깨끗해서 좋았습니다! 공기청정기가 구비되어 있어 창문을 닫아놓고도 쾌적했습니다! 전복죽과 빵 중에서 하나를 선택해서 조식을 먹을 수 있었는데 맛도 비주얼도 카페 못지 않게 뛰어났어요 ㅎㅎㅎ 위치가 조금 외진 것 외에는 여러모로 다 만족스러웠습니다! 특히 호스트님이 근처 관광지를 하나하나 설명해주시고, 맛집도 추천해주셔서 새로운 제주를 만날 수 있었어요! 다음에도 제주에 가면 이곳에서 묵으려구요","경치도 좋고 위치도 좋고- 너무 친절하고! 다음에도 제주도를 가게 되면 또 갈거 같아요 ❤️"]
    
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
            cell.addBorderBottom(size: 1.0, color: UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1))
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewListCell", for: indexPath) as! ReviewListCell
            
            cell.reviewProfile.kf.setImage(with: URL(string: reviewImages[indexPath.row]), placeholder: UIImage(named: "profile"))
            cell.reviewName.text = reviewNames[indexPath.row]
            cell.reviewDate.text = reviewDates[indexPath.row]
            cell.reviewMent.text = reviewMent[indexPath.row]
            cell.addBorderBottom(size: 1.0, color: UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1))
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
