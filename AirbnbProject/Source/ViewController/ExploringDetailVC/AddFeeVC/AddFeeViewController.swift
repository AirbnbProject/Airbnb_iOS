//
//  AddFeeViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class AddFeeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let addFeeOptions = ["청소비", "추가 인원 요금", "보증금", "주말 요금"]
    let addFeePrices = ["₩12960", "추가요금 없음", "₩129596", "₩76462 / 박"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(
            UINib(nibName: "AddFeeCell", bundle: nil),
            forCellWithReuseIdentifier: "AddFeeCell"
        )
        
        collectionView.register(
            UINib(nibName: "AddFeeTitle", bundle: nil),
            forCellWithReuseIdentifier: "AddFeeTitle"
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

extension AddFeeViewController: UICollectionViewDataSource {
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
         return addFeePrices.count
        }
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFeeTitle", for: indexPath) as! AddFeeTitle
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddFeeCell", for: indexPath) as! AddFeeCell
            cell.addFeeOption.text = addFeeOptions[indexPath.row]
            cell.addFeePrice.text = addFeePrices[indexPath.row]
            cell.addBorderBottom(size: 1.0, color: .gray)
            return cell
        }
    }
    
}

extension AddFeeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 100)
        }else {
            return CGSize(width: view.frame.width, height: 90)
        }
    }
}
