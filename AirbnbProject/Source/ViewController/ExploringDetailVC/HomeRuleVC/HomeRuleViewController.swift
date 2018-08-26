//
//  HomeRuleViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class HomeRuleViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var hostName = String()
    var ruleLists = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(nibName: "HomeRuleBoldCell", bundle: nil),
            forCellWithReuseIdentifier: "HomeRuleBoldCell"
        )
        
        collectionView.register(
            UINib(nibName: "HomeRuleCell", bundle: nil),
            forCellWithReuseIdentifier: "HomeRuleCell"
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

extension HomeRuleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        if section == 0 {
            return 1
        }else {
            return ruleLists.count
        }
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeRuleBoldCell", for: indexPath) as! HomeRuleBoldCell
            cell.ruleTitle.text = "\(hostName) 님의 숙소 이용규칙 확인하기"
            cell.ruleSub.text = "다음은 \(hostName)님의 숙소에서 지켜야 할 가이드라인과 숙지할 사항입니다"
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeRuleCell", for: indexPath) as! HomeRuleCell
            cell.ruleList.text = ruleLists[indexPath.row]
            cell.addBorderBottom(size: 1.0, color: .gray)
            return cell
        }
    }
    
}

extension HomeRuleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 150)
        }else {
            return CGSize(width: view.frame.width, height: 90)
        }
    }
}
