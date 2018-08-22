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
    func signIn(email: String, password: String, completion: @escaping (Result<UserLogin>) -> ())
    func signUp(firstName: String, lastName: String, email: String, birthday: String, password: String, completion: @escaping (Result<UserSignUp>) -> ())
    func facebookSignIn(email: String, id: String, firstName: String, lastName: String, url: String, completion: @escaping (Result<UserLogin>) -> ())
    func emailCheck(email: String, completion: @escaping (Result<EmailCheck>) -> ())
    func findPassword(email: String, completion: @escaping (Result<FindPassword>) -> ())
}

struct AuthService: AuthServiceType {
    
    func signIn(email: String, password: String, completion: @escaping (Result<UserLogin>) -> ()) {
        print("\n-------- [ signIn ] --------\n")
        
        let parameter: Parameters = [ "username" : email,
                                      "password": password ]
        
        
        
        Alamofire.request(API.Auth.login, method: .post, parameters: parameter)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let decodableValue = try JSONDecoder().decode(UserLogin.self, from: value)
                        completion(Result.success(decodableValue))
                    } catch {
                        completion(Result.failure(nil, error))
                    }
                case .failure(let error):
                    do {
                        completion(.failure(response.data!, error))
                    }
                    
                }
            }
        }

    func signUp(firstName: String, lastName: String, email: String, birthday: String, password: String, completion: @escaping (Result<UserSignUp>) -> ()) {
        print("\n-------- [ signupPost ] --------\n")
        requestService(url: API.Auth.signUp, firstName: firstName, lastName: lastName, email: email, birthday: birthday, password: password, completion: completion)
    }
    
    func emailCheck(email: String, completion: @escaping (Result<EmailCheck>) -> ()) {
        guard validateEmail(email: email) else { return completion(Result.failure(nil, AuthError.invalidEmail)) }
        
        let parameter: Parameters = [ "username" : email ]
        
        Alamofire
            .request(API.Auth.emailCheck, method: .post, parameters: parameter)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let decodeValue = try JSONDecoder().decode(EmailCheck.self, from: value)
                        completion(Result.success(decodeValue))
                    } catch {
                        completion(Result.failure(nil, error))
                    }
                case .failure(let error):
                    completion(.failure(response.data!, error))
                }
        }
    }

    func facebookSignIn(email: String, id: String, firstName: String, lastName: String, url: String, completion: @escaping (Result<UserLogin>) -> ()) {
        
        let parameter: Parameters = [ "email" : email,
                                      "id" :  id,
                                      "first_name" : firstName,
                                      "last_name" : lastName,
                                      "url" : url ]
        
        Alamofire
            .request(API.Auth.facebookLogin, method: .post, parameters: parameter)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let decodeValue = try JSONDecoder().decode(UserLogin.self, from: value)
                        completion(Result.success(decodeValue))
                    } catch {
                        completion(Result.failure(nil, error))
                    }
                case .failure(let error):
                    completion(.failure(response.data!, error))
                }
        }
    }
    
    func requestService(url: String, firstName: String, lastName: String, email: String, birthday: String, password: String, completion: @escaping (Result<UserSignUp>) -> ()) {
        
        guard validUserName(firstName: firstName, lastName: lastName) else { return completion(Result.failure(nil, AuthError.invalidUsername)) }
        guard validateEmail(email: email) else { return completion(Result.failure(nil, AuthError.invalidEmail)) }
        guard validateAdult(birthDay: birthday) else { return completion(Result.failure(nil, AuthError.invalidBirthDay)) }
        guard validatePassword(password: password) else { return completion(Result.failure(nil, AuthError.invalidPassword)) }

        let parameter: Parameters = [
            "first_name" : firstName,
            "last_name" : lastName,
            "username" : email,
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
                        print("Decodable:",decodeValue)
                        completion(.success(decodeValue))
                    } catch {
                        completion(Result.failure(nil, error))
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func findPassword(email: String, completion: @escaping (Result<FindPassword>) -> ()) {
        Alamofire
            .request(API.Auth.findPassword)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let decodeValue = try JSONDecoder().decode(FindPassword.self, from: value)
                        print("Decodable:",decodeValue)
                        completion(.success(decodeValue))
                    } catch {
                        completion(Result.failure(nil, error))
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func validUserName(firstName: String, lastName: String) -> Bool {
        guard firstName.count > 0 else { return false }
        guard lastName.count > 0 else { return false }
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
        
        if age >= 18 { return true }
        
        return false
    }
    
    func validatePassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,50}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
}

