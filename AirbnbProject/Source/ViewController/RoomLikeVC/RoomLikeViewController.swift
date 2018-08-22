//
//  RoomLikeViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 21..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class RoomLikeViewController: UIViewController {
    
    var noCountLabel = UILabel(frame: CGRect(x: 125, y: 270, width: 130, height: 30))
    var lookMoreBtn = UIButton(frame: CGRect(x: 140, y: 300, width: 70, height: 50))
    
    private let roomListService: LikeRoomServiceType = LikeRoomService()
    
    private struct Metric {
        // collectionView
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let leftPadding: CGFloat = 10.0
        static let rightPadding: CGFloat = 10.0
        static let topPadding: CGFloat = 10.0
        static let bottomPadding: CGFloat = 10.0
    }
    
    var indexPath = IndexPath()
    var allInfo: [RoomLikeList]? = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLabel()
        makeBtn()
    }
    
    func settingInfo() {
        roomListService.likeRoomList(token: "b1e4cb34fd7a8bbd4e8ef7a589de9a25aaf3c1e5") { (result) in
            switch result {
            case .success(let value):
                print(value)
                self.allInfo = value
                print("yaho = \(value.count)")
                if self.allInfo!.count == 0 {
                    self.lookMoreBtn.isHidden = false
                    self.noCountLabel.isHidden = false
                    self.collectionView.isHidden = true
                }else {
                    self.lookMoreBtn.isHidden = true
                    self.noCountLabel.isHidden = true
                    self.collectionView.isHidden = false
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.register(
            UINib(nibName: "RoomLikeCell", bundle: nil),
            forCellWithReuseIdentifier: "RoomLikeCell"
        )
        settingInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeLabel() {
        noCountLabel.backgroundColor = .white
        noCountLabel.textColor = .black
        noCountLabel.text = "저장된 항목 없음"
        view.addSubview(noCountLabel)
    }
    
    func makeBtn() {
        lookMoreBtn.setTitle("둘러보기", for: .normal)
        lookMoreBtn.setTitleColor(.green, for: .normal)
        lookMoreBtn.backgroundColor = .white
        lookMoreBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        view.addSubview(lookMoreBtn)
    }
    
    @IBAction private func click(_ button: UIButton) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let homeView  = sampleStoryBoard.instantiateViewController(withIdentifier: "MainExploring")
        self.navigationController?.pushViewController(homeView, animated: true)
        //인수 뷰로 이동
    }
    
}

extension RoomLikeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return allInfo!.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomLikeCell", for: indexPath) as! RoomLikeCell
        guard (allInfo?.count)! > 0 else { return cell }
        let url = URL(string: allInfo![indexPath.row].roomsCoverThumbnail)
        cell.imageView.kf.setImage(with: url)
        cell.roomInfo.text = allInfo![indexPath.row].roomsType
        cell.roomName.text = allInfo![indexPath.row].roomsName
        cell.roomPrice.text = "￦\(allInfo![indexPath.row].daysPrice) /박"
        return cell
    }
    
}

extension RoomLikeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let homeView  = sampleStoryBoard.instantiateViewController(withIdentifier: "ExploringDetailViewController") as! ExploringDetailViewController
        homeView.deliveriedPK = allInfo![indexPath.row].pk
        self.navigationController?.pushViewController(homeView, animated: true)
        
    }
}
