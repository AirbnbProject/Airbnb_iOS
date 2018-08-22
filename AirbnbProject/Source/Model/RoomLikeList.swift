//
//  RoomLikeList.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 22..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation
import UIKit

struct RoomLikeList: Decodable {
    let pk: Int
    let roomsType: String
    let roomsName: String
    let roomsTag: String?
    let daysPrice: Int
    let roomsCoverThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case pk
        case roomsType = "rooms_type"
        case roomsName = "rooms_name"
        case roomsTag = "rooms_tag"
        case daysPrice = "days_price"
        case roomsCoverThumbnail = "rooms_cover_thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.pk = try value.decode(Int.self, forKey: .pk)
        self.roomsType = try value.decode(String.self, forKey: .roomsType)
        self.roomsName = try value.decode(String.self, forKey: .roomsName)
        self.roomsTag = try value.decodeIfPresent(String.self, forKey: .roomsTag)
        self.daysPrice = try value.decode(Int.self, forKey: .daysPrice)
        self.roomsCoverThumbnail = try value.decode(String.self, forKey: .roomsCoverThumbnail)
    }
    
}
