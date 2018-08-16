//
//  AuthenticatedInfoViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 16..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import WebKit

class AuthenticatedInfoViewController: UIViewController, WKNavigationDelegate{

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupWebview()
        
        webView.load(URLRequest(url: URL(string: "https://www.airbnb.co.kr/help/article/1237/how-does-it-work-when-airbnb-asks-for-an-id")!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupWebview() {
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupNavigation() {
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "arrow_left_black"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem(customView: backButton)
        navigationItem.setLeftBarButton(leftItem, animated: true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    

}
