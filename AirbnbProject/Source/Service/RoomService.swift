//
//  RoomService.swift
//  AirbnbProject
//
//  Created by 박인수 on 20/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import Foundation
import Alamofire

protocol RoomServiceType {
    func getRoomList(completion: @escaping (Result<Any>) -> ())
    func getTotalRoomList(region: String, completion: @escaping (Result<Any>) -> ())
    func getTotalRoomListInKorea(completion: @escaping (Result<Any>) -> ())
}

struct RoomService: RoomServiceType {
    
    func getRoomList(completion: @escaping (Result<Any>) -> ()) {
        
        Alamofire // Main VC 에 4개씩 뿌려주는 통신
            .request(API.MainPage.getRoomList, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.allowFragments)
                        completion(Result.success(data))
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
    
    func getTotalRoomList(region: String, completion: @escaping (Result<Any>) -> ()) {
        
        Alamofire   // Main VC 의 Footer 를 눌렀을 때 각 지역별로 보여줄 모든 숙소들을 뿌려주는 통신
            .request(API.MainPage.getTotalRoomList + region.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.allowFragments)
                        completion(Result.success(data))
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
    
    func getTotalRoomListInKorea(completion: @escaping (Result<Any>) -> ()) {
        
        Alamofire   // Main VC 중 대한민국 숙소 파트의 Footer 를 클릭했을 때 모든 숙소를 보여주기 위한 통신.
            .request(API.MainPage.getTotalRoomListInKorea, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.allowFragments)
                        completion(Result.success(data))
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
    
    func getSearchResultByKeyword(inputKeyword: String, completion: @escaping (Result<Any>) -> ()) {
        
        Alamofire
            .request(API.MainPage.getSearchResultByKeyword + "\(inputKeyword)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.allowFragments)
                        completion(Result.success(data))
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
    
    
    
}



