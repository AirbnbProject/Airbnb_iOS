//
//  LikeListService.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 22..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation
import Alamofire

protocol LikeRoomServiceType {
    func likeRoomList(token: String, completion: @escaping (Result<[RoomLikeList]>) -> ())
}

struct LikeRoomService: LikeRoomServiceType {
    func likeRoomList(token: String, completion: @escaping (Result<[RoomLikeList]>) -> ()) {
        
        let header: HTTPHeaders = ["Authorization" : "Token " + token]
        
        Alamofire
            .request(API.RoomLike.likeList, method: .get, headers: header)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode([RoomLikeList].self, from: value)
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
