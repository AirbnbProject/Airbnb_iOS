//
//  PageStyleHouseListCollectionCell.swift
//  AirbnbProject
//
//  Created by 박인수 on 15/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit



class PageStyleHouseListCollectionCell: UICollectionViewCell {

    @IBOutlet weak var pageStyleHouseListScrollView: UIScrollView!
    @IBOutlet weak var pageStyleHouseListPageControl: UIPageControl!
    
    @IBOutlet weak var tagTitle: UILabel!
    @IBOutlet weak var regionTitle: UILabel!
    @IBOutlet weak var houseTitle: UILabel!
    @IBOutlet weak var currencySymbolTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var byDayTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Setup
    
    private func setupUI() {
        

        pageStyleHouseListScrollView.isPagingEnabled = true
        pageStyleHouseListScrollView.delegate = self

        
        let pageColors: [UIColor] = [.red, .blue, .gray, .magenta]
        pageColors.forEach(addPageToScrollView(with:))
        
        pageStyleHouseListPageControl.frame = CGRect(
            x: self.pageStyleHouseListScrollView.frame.midX - 20, y: self.pageStyleHouseListScrollView.frame.height - 60, width: 40, height: 20
        )
    }

    private func addPageToScrollView(with color: UIColor) {
        let pageFrame = CGRect(
            origin: CGPoint(x: pageStyleHouseListScrollView.frame.width, y: 0),
            size: pageStyleHouseListScrollView.frame.size
        )
        let colorView = UIView(frame: pageFrame)
        colorView.backgroundColor = color.withAlphaComponent(0.6)
        pageStyleHouseListScrollView.addSubview(colorView)
        
        pageStyleHouseListScrollView.contentSize.width += pageStyleHouseListScrollView.frame.width
        pageStyleHouseListPageControl.numberOfPages += 1
    }
    
}

extension PageStyleHouseListCollectionCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageStyleHouseListPageControl.currentPage = page
    }
}
