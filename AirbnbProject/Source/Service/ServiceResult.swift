//
//  ServiceResult.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(response: [String:Any]?, error: Error)
}

enum AuthError: Error {
    case invalidUsername
    case invalidEmail
    case invalidBirthDay
    case invalidPassword
}

