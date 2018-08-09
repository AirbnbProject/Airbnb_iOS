//
//  swipeImageCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

protocol ImageViewDelegate: class {
    func ImageClick(_ itemCell: swipeImageCell, didTapAddButton: UIImageView)
}

class swipeImageCell: UICollectionViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    weak var delegate: ImageViewDelegate?
    
    var imageList = ["cameras", "eraser", "dj", "woman"]
    var updateCounter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControl.numberOfPages = imageList.count
        var frame = CGRect(x:0, y:0, width:0, height:0)
        for i in 0..<imageList.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(i)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: imageList[i])
            self.scrollView.addSubview(imageView)
            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
            //
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            //
            
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(imageList.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self as? UIScrollViewDelegate
        scrollView.isPagingEnabled = true
    }
    //
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        delegate?.ImageClick(self, didTapAddButton: tappedImage)
    }
    //
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    @objc func moveToNextPage() {
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
//        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//        pageControl.currentPage = Int(pageNumber) + 1
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width + 1
        print(pageNumber)
        if Int(pageNumber) < imageList.count {
            pageControl.currentPage = Int(pageNumber)
        }else {
            pageControl.currentPage = 0
        }
        
    }

}

extension swipeImageCell: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_: UIScrollView, willDecelerate: Bool) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width + 1
        if Int(pageNumber) < imageList.count {
            pageControl.currentPage = Int(pageNumber)
        }else {
            pageControl.currentPage = 0
        }
    }
}
