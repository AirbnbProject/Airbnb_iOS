//
//  UserProfile.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 14..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

/*
 {
 "profile_image": "https://fc-airbnb-project.s3.amazonaws.com/media/profile_image/profile_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI2BXOTY66NHNMYIQ%2F20180814%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20180814T110501Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=5d83af17c40aae36a5e84295e56f843fb6ee4c475088da2aff110ce062ac8a1a",
 "phone_number": "",
 "birthday": "",
 "first_name": "승진",
 "last_name": "김",
 "is_host": false
 }
 */

struct UserInfo: Decodable {
    let profileImage: String?
    let phoneNumber: String?
    let birthday: String?
    let firstName: String
    let lastName: String
    let isHost: Bool
    
    enum Codingkeys: String, CodingKey {
        case profileImage = "profile_image"
        case phoneNumber = "phone_number"
        case birthday
        case firstName = "first_name"
        case lastName = "last_name"
        case isHost = "is_host"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Codingkeys.self)
        self.profileImage = try value.decode(String.self, forKey: .profileImage)
        self.phoneNumber = try value.decode(String.self, forKey: .phoneNumber)
        self.birthday = try value.decode(String.self, forKey: .birthday)
        self.firstName = try value.decode(String.self, forKey: .firstName)
        self.lastName = try value.decode(String.self, forKey: .lastName)
        self.isHost = try value.decode(Bool.self, forKey: .isHost)
    }
    
}
