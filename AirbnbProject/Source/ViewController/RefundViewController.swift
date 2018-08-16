//
//  RefundViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class RefundViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var refundRule = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(nibName: "RefundCell", bundle: nil),
            forCellWithReuseIdentifier: "RefundCell"
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

extension RefundViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return 1
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RefundCell", for: indexPath) as! RefundCell
            cell.refundText.text = refundRule
            return cell
    }
    
}

extension RefundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        return CGSize(width: view.frame.width, height: 600)
    }
}
