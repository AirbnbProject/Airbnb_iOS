//
//  DefineConstants.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "https://leesoo.kr"
    
    enum Auth {
        static let signUp = API.baseURL + "/members/signup/"
        static let login = API.baseURL + "/members/login/"
        static let loginOut = API.baseURL + "/members/logout"
        static let emailCheck = API.baseURL + "/members/emailcheck/"
    }
}

