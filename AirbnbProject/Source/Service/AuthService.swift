//
//  AuthService.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthServiceType {
    func singUp(userName: String, email: String, birthday: String, password: String, completion: @escaping (Result<UserSignUp>) -> ())
}

struct AuthService: AuthServiceType {
    
    func singUp(userName: String, email: String, birthday: String, password: String, completion: @escaping (Result<UserSignUp>) -> ()) {
        print("\n-------- [ signupPost ] --------\n")
        requestService(url: API.Auth.signUp, username: userName, email: email, birthday: birthday, password: password, completion: completion)
    }
    
    func requestService(url: String, username: String, email: String, birthday: String, password: String, completion: @escaping (Result<UserSignUp>) -> ()) {
        
        guard validUserName(username: username) else { return completion(Result.failure(response: nil, error: AuthError.invalidUsername)) }
        guard validateEmail(email: email) else { return completion(Result.failure(response: nil, error: AuthError.invalidEmail)) }
        guard validateAdult(birthDay: birthday) else { return completion(Result.failure(response: nil, error: AuthError.invalidBirthDay)) }
        guard validatePassword(password: password) else { return completion(Result.failure(response: nil, error: AuthError.invalidPassword)) }

        let parameter: Parameters = [
            "username" : username,
            "email" : email,
            "birthday" : birthday,
            "password" : password
        ]
        
        Alamofire
            .request(url, method: .post, parameters: parameter)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let decodeValue = try JSONDecoder().decode(UserSignUp.self, from: value)
                        completion(.success(decodeValue))
                    } catch {
                        completion(Result.failure(response: nil, error: error))
                    }
                case .failure(let error):
                    if let data = response.data {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String : Any] {
                            completion(.failure(response: json, error: error))
                        }
                    }
                }
        }
    }
    
    func validUserName(username: String) -> Bool {
        guard username.count > 0 else { return false }
        return true
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    func validateAdult(birthDay: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ko_kr")
        dateFormatter.dateFormat = "YYYY"
        
        let date = Date()
        let nowYear = dateFormatter.string(from: date)
        
        let inputYear = birthDay.split(separator: ".")[0]
        let age = Int(nowYear)! - Int(inputYear)! + 1
        
        print(Int(nowYear)! - Int(inputYear)! + 1)
        
        if age >= 18 { return true }
        
        return false
    }
    
    func validatePassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,50}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
}

