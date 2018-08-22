//
//  SearchBarViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 04/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit
import Alamofire

class SearchBarViewController: UIViewController {
    
    // UI VIEW PROPERTY
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var deletingAllTextButton: UIButton!
    
    
    // TABLE VIEW PROPERTY
    @IBOutlet weak var tableView: UITableView!
    
    
    // Data Property
    var inputText: String = ""
    
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        return true
    }
    
    // 여기에 트루주면 글자를 쓰다가 키보드를 내리고 다시 올릴 경우 글자가 작성중임 상태임에도 삭제 버튼이 사라지는 경우가 발생. 물론 키보드 치면 다시 나타나긴함.
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.deletingAllTextButton.isHidden = true
//        print("textFieldDidBeginEditing")
//    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.deletingAllTextButton.isHidden = true
//        print("textFieldDidEndEditing")
//    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.deletingAllTextButton.isHidden = true
        print("textFieldShouldClear")
        return true
    }
    
    // 여기에 설정하면 빈 부분을 눌러 키보드를 내렸을 때 삭제 버튼도 함께 사라지는 경우가 발생.
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        self.deletingAllTextButton.isHidden = true
//        print("textFieldShouldBeginEditing")
//        return true
//    }

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

