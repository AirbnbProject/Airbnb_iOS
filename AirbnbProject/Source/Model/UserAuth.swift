//
//  UserAuth.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 8..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

//회원가입 모델
struct UserSignUp: Decodable {
    
    let firstName: String
    let lastName: String
    let userName: String
    let birthday: String
    let password: String

    enum Codingkeys: String, CodingKey {
        case birthday, password
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Codingkeys.self)
        self.firstName = try value.decode(String.self, forKey: .firstName)
        self.lastName = try value.decode(String.self, forKey: .lastName)
        self.userName = try value.decode(String.self, forKey: .userName)
        self.birthday = try value.decode(String.self, forKey: .birthday)
        self.password = try value.decode(String.self, forKey: .password)
    }
}

//로그인 모델
struct UserLogin: Decodable {
    
    let token: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case token
        case user
    }
    
    struct User: Decodable {
        
        let firstName: String
        let lastName: String
        let profileImage: String?
        let phoneNumber: String?
        let birthday: String?
        let isHost: Bool
        let createDate: String
//        let likesPost: [String]?
        
        enum UserKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case userName = "username"
            case profileImage = "profile_image"
            case phoneNumber = "phone_number"
            case birthday
            case isHost = "is_host"
            case createDate = "create_date"
//            case likesPost = "likes_posts"
        }
        
        init(from decoder: Decoder) throws {
            let nestedContainer = try decoder.container(keyedBy: UserKeys.self)
            self.firstName = try nestedContainer.decode(String.self, forKey: .firstName)
            self.lastName = try nestedContainer.decode(String.self, forKey: .lastName)
            self.profileImage = try nestedContainer.decodeIfPresent(String.self, forKey: .profileImage)
            self.phoneNumber = try nestedContainer.decodeIfPresent(String.self, forKey: .phoneNumber)
            self.birthday = try nestedContainer.decodeIfPresent(String.self, forKey: .birthday)
            self.isHost = try nestedContainer.decode(Bool.self, forKey: .isHost)
            self.createDate = try nestedContainer.decode(String.self, forKey: .createDate)
//            self.likesPost = try nestedContainer.decodeIfPresent([String].self, forKey: .likesPost)
        }
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try values.decode(String.self, forKey: .token)
        self.user = try values.decode(User.self, forKey: .user)
    }

}

//이메일 중복 모델
struct EmailCheck: Codable {
    let username: String
}

// 페이스북 로그인 모델
struct FacebookLogin: Decodable {
    let email: String
    let id: String
    let lastName: String
    let firstName: String
    let url: String
    
    enum Codingkeys: String, CodingKey {
        case email, id, url
        case lastName = "last_name"
        case firstName = "first_name"
    }
}

//비밀번호 찾기
struct FindPassword: Decodable {
    let email: String
}



