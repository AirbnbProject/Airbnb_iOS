//
//  MessageViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 16..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

private enum Constaint {
    static let messageHeaderHeight: CGFloat = 138.0
    static let messageListHeight: CGFloat = 120.0
}

class MessageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let fakeContents = ["안녕하세요, 숙박 예약 문의차 연락 드렸습니다.","안녕하세요, 홍길동입니다.","안녕하세요, 동대문 숙소 28일 날짜 가능한가요?", "반갑습니다. 숙소 위치가 서울시 동대문구 답십리 22-15 1층 주소가 맞나요?", "안녕하세요."]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupInitialize() {
        
        self.tableView.delegate = self 
        self.tableView.dataSource = self
    }

}

extension MessageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageListCell", for: indexPath) as! MessageListCell
        
        
        cell.messageContent.text = fakeContents[indexPath.row]
//        if let image = self.userDetailInfo["profileImage"] {
//            cell.profile.kf.setImage(with: URL(string: image as! String), placeholder: UIImage(named: "profile"))
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageHeaderView")
        return cell
    }
    
}

extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constaint.messageHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constaint.messageListHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = MoveStoryboard.toVC(storybardName: "Message", identifier: "ChattingViewController")
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
}

