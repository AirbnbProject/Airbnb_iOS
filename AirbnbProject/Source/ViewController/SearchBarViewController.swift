//
//  SearchBarViewController.swift
//  AirbnbProject
//
//  Created by 박인수 on 04/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {
    
    // UI VIEW PROPERTY
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    // TABLE VIEW PROPERTY
    
    @IBOutlet weak var tableView: UITableView!
    
    // VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        searchTextField.becomeFirstResponder()
        
        //        tableView.dataSource = self
                tableView.delegate = self
        view.addSubview(tableView)
        //        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        

        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "'코스타 트로피칼'에 가보는 건 어떠세요?", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.boldSystemFont(ofSize: 24.0)
            ])
        
        
    }
    
    
    
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func searchTextFieldEditingChanged(_ sender: UITextField) {
        
        
//       guard (searchTextField.text?.count)! > 0 else  {
//                recommandationLabel.isHidden = false
//                return
//            }
//
//        recommandationLabel.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
}

extension SearchBarViewController: UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
////
////
////        recommandationLabel.isHidden = true
////        return true
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        self.dismiss(animated: true)
        return true
    }
    
    
    
    
}

extension SearchBarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder()
    }
}

//extension SearchBarViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20 // 검색한 기록을 테이블 뷰에 쌓는 식으로 해야함.
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
//    }  // 여기에 이제 검색한 기록이 넘어와서 하나씩 쌓이게 된다.
//}

//extension SearchBarViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        <#code#>
//    }
//} 여기에는 클릭했을때 화면이 디스미스되고 그 검색한 내용에 맞는 내용이 Exploring 에 뜨게 해야함.
