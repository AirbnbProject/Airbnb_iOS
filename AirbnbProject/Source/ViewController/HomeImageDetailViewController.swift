//
//  HomeImageDetailView.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 8..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

class HomeImageDetailViewController: UIViewController {

    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var homeImage = Array<String>()
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(homeImage.count) , height: scrollView.frame.height)
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        for i in 0..<homeImage.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(i)
            frame.size = scrollView.frame.size
            imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: homeImage[i])
            self.scrollView.addSubview(imageView)
        }
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
//        scrollView.minimumZoomScale = 1.0
//        scrollView.maximumZoomScale = 2.0
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        imageCountLabel.text = "1 / \(homeImage.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                self.dismiss(animated: true)
            default:
                break
            }
        }
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension HomeImageDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width + 1
        imageCountLabel.text = "\(Int(pageNumber)) / \(homeImage.count)"
        imageCountLabel.isHidden = false
    }
    
    func scrollViewWillBeginDragging(_: UIScrollView) {
        imageCountLabel.isHidden = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
