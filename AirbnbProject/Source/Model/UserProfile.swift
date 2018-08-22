//
//  UserProfile.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 14..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

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
