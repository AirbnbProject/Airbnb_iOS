//
//  RoomDetailInfoService.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 20..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation
import Alamofire

protocol RoomDetailServiceType {
    func searchRoomDetailInfo(pk: Int, completion: @escaping (Result<[RoomDetail]>) -> ())
}

struct RoomDetailService: RoomDetailServiceType {
    func searchRoomDetailInfo(pk: Int, completion: @escaping (Result<[RoomDetail]>) -> ()) {

        var api = "\(API.RoomDetail.detailInfo)\(pk)"
        Alamofire
            .request(api, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode([RoomDetail].self, from: value)
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
 
