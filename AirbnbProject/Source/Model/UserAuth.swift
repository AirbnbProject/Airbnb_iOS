//
//  UserAuth.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 8..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

//회원가입 모델
struct UserSignUp: Codable {
    let username: String
    let email: String
    let birthday: String
    let password: String
}

struct UserLogin: Codable {
//  {
//    "token": "<user_token_key>",
//    "user": {
    //    "username": "<user_email>",
    //    "profile_image": "<user_profile_image>",
    //    "phone_number": "<user_phone_number>",
    //    "birthday": "<user_birthday>",
    //    "is_host": false,
    //    "likes_posts": []
//    }
//  }
    
    /*
     let pk: Int
     let username: String
     var firstName: String?
     var lastName: String?
     var email: String?
     
     enum CodingKeys: String, CodingKey {
     case user
     case token
     }
     
     enum AdditionalInfoKeys: String, CodingKey {
     case pk
     case username
     case firstName = "first_name"
     case lastName = "last_name"
     case email
     }
     
     init(from decoder: Decoder) throws {
     let values = try decoder.container(keyedBy: CodingKeys.self)
     let token = try values.decodeIfPresent(String.self, forKey: .token)
     
     let userDict: KeyedDecodingContainer<User.AdditionalInfoKeys>
     if token != nil {
     UserManager.token = token
     userDict = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .user)
     } else {
     userDict = try decoder.container(keyedBy: AdditionalInfoKeys.self)
     }
     
     pk = try userDict.decode(Int.self, forKey: .pk)
     username = try userDict.decode(String.self, forKey: .username)
     firstName = try userDict.decodeIfPresent(String.self, forKey: .firstName)
     lastName = try userDict.decodeIfPresent(String.self, forKey: .lastName)
     email = try userDict.decodeIfPresent(String.self, forKey: .email)
     }
 */
    
    
    let token: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case token
        case user
    }
    
    struct User: Codable {
        let username: String
        let profile_image: String?
        let phone_number: String
        let birthday: String
        let is_host: Bool
        let likes_posts: [String]?
        
        enum Codingkeys: String, CodingKey {
            case username, birthday
            case profileImage = "profile_image"
            case phoneNumber = "phone_number"
            case isHost = "is_host"
            case likesPosts = "likes_posts"
        }
    }
    
//    init(from decoder: Decoder) throws {
//        
//    }
    
    //TODO: - 마무리
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let token = try values.decode(String.self, forKey: .token)
//
//    }
    
}

//이메일 중복 모델
struct EmailCheck: Codable {
    let username: String
}


