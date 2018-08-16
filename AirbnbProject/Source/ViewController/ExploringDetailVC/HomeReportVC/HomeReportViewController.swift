//
//  HomeReportViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 13..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class HomeReportViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let reportOption = ["부정확하거나 틀린 정보가 있어요", "살제 숙소가 아닙니다", "사기입니다", "불쾌합니다", "기타"]
    var arr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(nibName: "ReportBoldCell", bundle: nil),
            forCellWithReuseIdentifier: "ReportBoldCell"
        )
        
        collectionView.register(
            UINib(nibName: "ReportCell", bundle: nil),
            forCellWithReuseIdentifier: "ReportCell"
        )
        
        collectionView.register(
            UINib(nibName: "ReportNextCell", bundle: nil),
            forCellWithReuseIdentifier: "ReportNextCell"
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

extension HomeReportViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return reportOption.count
        }else {
            return 1
        }
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportBoldCell", for: indexPath) as! ReportBoldCell
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCell", for: indexPath) as! ReportCell
            cell.reportLabel.text = reportOption[indexPath.row]
            cell.reportLabel.tag = indexPath.row
            cell.delegate = self
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportNextCell", for: indexPath) as! ReportNextCell
            cell.delegate = self
            return cell
        }
    }
    
}

extension HomeReportViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 150)
        }else {
            return CGSize(width: view.frame.width, height: 70)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeReportViewController: ReportDelegate {
    func ReportRadioCell(_ itemCell: ReportCell, didTapAddButton: UIButton) {
        if didTapAddButton.isSelected == false {
            didTapAddButton.isSelected = true
            didTapAddButton.setImage(UIImage(named: "selected"), for: .selected)
            arr.append(reportOption[itemCell.reportLabel.tag])
        }else {
            didTapAddButton.isSelected = false
            didTapAddButton.setImage(nil, for: .normal)
            arr = arr.filter { $0 != reportOption[itemCell.reportLabel.tag] }
        }
    }
}

extension HomeReportViewController: ReportNextDelegate {
    func ReportNextCell(_ itemCell: ReportNextCell, didTapAddButton: UIButton) {
        if arr.count == 0 {
            let nonController = UIAlertController(title: "알림", message: "신고항목을 한가지 이상 선택해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            let nonAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            nonController.addAction(nonAction)
            self.present(nonController,animated: true,completion: nil)
        }else {
            //
            let reportController = UIAlertController(title: "", message: "신고 되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
            let reportAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
                self.dismiss(animated: true)
            }
            reportController.addAction(reportAction)
            //
            var text = "\(arr)"
            var text1 = text.substring(from: text.index(after: text.startIndex))
            var text2 = text1.substring(to: text1.index(before: text1.endIndex))
            let alertController = UIAlertController(title: "신고", message: "\(text2) 의 이유로 이 숙소를 신고하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "신고", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
                self.present(reportController,animated: true,completion: nil)
            }
            let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelButton)
            self.present(alertController,animated: true,completion: nil)
        }
    }
}
