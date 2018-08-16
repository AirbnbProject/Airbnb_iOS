//
//  RoomInfo.swift
//  AirbnbProject
//
//  Created by 박인수 on 14/08/2018.
//  Copyright © 2018 김승진. All rights reserved.
//

import UIKit

struct RoomInfo : Decodable {
    
    let count: Int
    let next: Int?
    let previous: Int?
    struct results {
        let roomsHost: Int
        let roomsName: String
        let roomstag: String
        let daysPrice: Int
        
        enum CodingKeys: String, CodingKey {
            case roomsHost = "rooms_host"
            case roomsName = "rooms_name"
            case roomstag = "rooms_tag"
            case daysPrice = "days_price"
        }
    }
    
}

