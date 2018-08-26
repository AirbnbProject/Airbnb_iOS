//
//  SearchBarViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 04/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class SearchBarViewController: UIViewController {
    
    // UI VIEW PROPERTY
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var deletingAllTextButton: UIButton!
    
    // TABLE VIEW PROPERTY
    @IBOutlet weak var tableView: UITableView!
    
    // Data Property
    var inputText: String = ""
    let roomService: RoomServiceType = RoomService()
    var activityView: NVActivityIndicatorView!
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        
        self.searchTextField.delegate = self
        self.searchTextField.becomeFirstResponder()
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "'코스타 트로피칼'에 가보는 건 어떠세요?", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.boldSystemFont(ofSize: 24.0)
            ])
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        
        self.deletingAllTextButton.isHidden = true
    }
    
    private func setupActivityIndicator() {
        activityView = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), padding: 25)
        
        activityView.backgroundColor = .white
        activityView.layer.cornerRadius = 10
        self.view.addSubview(activityView)
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

extension SearchBarViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputText = textField.text!
        searchTextField.resignFirstResponder()
        print("resignFirstResponder 2nd") // 첫번째 출력
        
        UserDefaults.standard.removeObject(forKey: "searchResult")
        
        activityView.startAnimating()
        
        roomService.getSearchResultByKeyword(inputKeyword: textField.text!) { (result) in
            switch result {
            case .success(let value):
                self.activityView.stopAnimating()
                
                UserDefaults.standard.set(textField.text!, forKey: "searchResult")

                print("value",value)
                self.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                self.activityView.stopAnimating()
                print(error)
            }
        }
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.deletingAllTextButton.isHidden = true
        print("textFieldShouldClear")
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 이 문장에 문제 있음. 왜 자음을 눌렀을 때 사라지냐고!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        if ((textField.text?.isEmpty)!) {
//            self.deletingAllTextButton.isHidden = true
//        } else {
//            self.deletingAllTextButton.isHidden = false
//        }
//            return true
        
        self.deletingAllTextButton.isHidden = false
        return true
    }
    
    
}

//MARK:- UITABLEVIEW DATA SOURCE & DELEGATE

extension SearchBarViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // 검색한 기록을 테이블 뷰에 쌓는 식으로 해야함.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        
        return UITableViewCell()
    }  // 여기에 이제 검색한 기록이 넘어와서 하나씩 쌓이게 된다.
}

//extension SearchBarViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        <#code#>
//    }
//} 여기에는 클릭했을때 화면이 디스미스되고 그 검색한 내용에 맞는 내용이 Exploring 에 뜨게 해야함.


extension SearchBarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder() // 요거 왜 안돼?
    }
}

