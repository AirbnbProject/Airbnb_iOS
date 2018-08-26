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
    func patchProfile(token: String, profileImage: UIImage, phoneNumber: String, birthDay: String, email: String, completion: @escaping (Result<Any>) -> ())
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
    
    func patchProfile(token: String, profileImage: UIImage, phoneNumber: String, birthDay: String, email: String, completion: @escaping (Result<Any>) -> ()) {
        
        let header: HTTPHeaders = ["Authorization" : "Token " + token]
//        let parameter: Parameters = [ "profile_image" : profileImage,
//                                      "phone_number" : phoneNumber,
//                                      "birthday" : birthDay,
//                                      "email" : email]
        
        let parameter: Parameters = [ "profile_image" : profileImage ]

        let request = try! URLRequest(url: API.UserInfo.fetchProfile, method: .patch, headers: header)
        
        Alamofire.upload(multipartFormData: { (multipartform) in
            multipartform.append(UIImageJPEGRepresentation(profileImage, 1.0)!, withName: "img_cover", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, with: request) { (multipartEncodingResult) in
            switch multipartEncodingResult {
            case let .success(request: request, streamingFromDisk: _, streamFileURL: _):
                request
                    .responseData { response in
                        switch response.result { 
                        case .success(let value):
                            
                            print("Success", value)
//                            do {
//                                let decodableValue = try JSONDecoder().decode(UserInfo.self, from: value)
//                                print(decodableValue)
//                                completion(Result.success(decodableValue))
//                            } catch {
//                                completion(.failure(nil, error))
//                            }
                            do {
                                let data = try JSONSerialization.jsonObject(with: value, options: [])
                                completion(Result.success(data))
                            } catch {
                                completion(.failure(nil, error))
                            }
                        case .failure(let error):
                            completion(.failure(response.data!, error))
                        }
                }
            case .failure(let error):
                print("error :",error)
            }
        }
        
        
        
    }
}
