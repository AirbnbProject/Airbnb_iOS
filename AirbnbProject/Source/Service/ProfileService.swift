//
//  ProfileService.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 14..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation
import Alamofire

protocol ProfileServiceType {
    func fetchProfile(token: String, completion: @escaping (Result<UserInfo>) -> ())
}

struct ProfileService: ProfileServiceType {
    func fetchProfile(token: String, completion: @escaping (Result<UserInfo>) -> ()) {
        
        let header: HTTPHeaders = ["Authorization" : "Token " + token]
        
        Alamofire
            .request(API.UserInfo.fetchProfile, method: .get, headers: header)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(UserInfo.self, from: value)
                        print(decodableValue)
                        completion(Result.success(decodableValue))
                    } catch {
                        completion(.failure(nil, error))
                    }
                case .failure(let error) :
                    completion(.failure(response.data!, error))
            }
        }
    }
}
