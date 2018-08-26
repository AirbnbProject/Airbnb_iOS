//////
//////  RoomDetailInfo.swift
//////  AirbnbProject
//////
//////  Created by 엄태형 on 2018. 8. 19..
//////  Copyright © 2018년 김승진. All rights reserved.
//////
import UIKit
struct RoomDetail: Decodable {
    let roomsType: String
    let roomsName: String
    let roomsTag: String
    let roomsHost: HostInfo
    let roomsCoverImage: String
    let roomImages: Array<[String :  String]>?
    let roomsAmount: Int
    let roomsBed: Int
    let roomsPersonnel: Int
    let roomsBathroom: Int
    let daysPrice: Int
    let roomRules: Array<[String :  String]>
    let roomFacilities: Array<[String :  String]>
    let roomsDescription: String
    let checkInMinimum: Int
    let checkInMaximum: Int
    // let roomReservation
    let refund: String
    let addressCountry: String
    let addressCity: String
    let addressDistrict: String
    let addressDetail: String
    let addressLatitude: String
    let addressLongitude: String

    enum CodingKeys: String, CodingKey {
        case roomsType = "rooms_type"
        case roomsName = "rooms_name"
        case roomsTag = "rooms_tag"
        case roomsHost = "rooms_host"
        case roomsCoverImage = "rooms_cover_image"
        case roomImages = "room_images"
        case roomsAmount = "rooms_amount"
        case roomsBed = "rooms_bed"
        case roomsPersonnel = "rooms_personnel"
        case roomsBathroom = "rooms_bathroom"
        case daysPrice = "days_price"
        case roomRules = "room_rules"
        case roomFacilities = "room_facilities"
        case roomsDescription = "rooms_description"
        case checkInMinimum = "check_in_minimum"
        case checkInMaximum = "check_in_maximum"
        case refund
        case addressCountry = "address_country"
        case addressCity = "address_city"
        case addressDistrict = "address_district"
        case addressDetail = "address_detail"
        case addressLatitude = "address_latitude"
        case addressLongitude = "address_longitude"
    }
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.roomsType = try value.decode(String.self, forKey: .roomsType)
        self.roomsName = try value.decode(String.self, forKey: .roomsName)
        self.roomsTag = try value.decode(String.self, forKey: .roomsTag)
        self.roomsHost = try value.decode(HostInfo.self, forKey: .roomsHost)
        self.roomsCoverImage = try value.decode(String.self, forKey: .roomsCoverImage)
        self.roomImages = try value.decodeIfPresent([[String :  String]].self, forKey: .roomImages)
        self.roomsAmount = try value.decode(Int.self, forKey: .roomsAmount)
        self.roomsBed = try value.decode(Int.self, forKey: .roomsBed)
        self.roomsPersonnel = try value.decode(Int.self, forKey: .roomsPersonnel)
        self.roomsBathroom = try value.decode(Int.self, forKey: .roomsBathroom)
        self.daysPrice = try value.decode(Int.self, forKey: .daysPrice)
        self.roomRules = try value.decode([[String :  String]].self, forKey: .roomRules)
        self.roomFacilities = try value.decode([[String :  String]].self, forKey: .roomFacilities)
        self.roomsDescription = try value.decode(String.self, forKey: .roomsDescription)
        self.checkInMinimum = try value.decode(Int.self, forKey: .checkInMinimum)
        self.checkInMaximum = try value.decode(Int.self, forKey: .checkInMaximum)
        self.refund = try value.decode(String.self, forKey: .refund)
        self.addressCountry = try value.decode(String.self, forKey: .addressCountry)
        self.addressCity = try value.decode(String.self, forKey: .addressCity)
        self.addressDistrict = try value.decode(String.self, forKey: .addressDistrict)
        self.addressDetail = try value.decode(String.self, forKey: .addressDetail)
        self.addressLatitude = try value.decode(String.self, forKey: .addressLatitude)
        self.addressLongitude = try value.decode(String.self, forKey: .addressLongitude)
    }
    //Host
struct HostInfo: Decodable {
    let firstName: String
//        let lastName: String?
    let profileImage: String
    let phoneNumber: String
//        let birthDay: String
    let isHost: Bool
    // let likesPosts

    enum Codingkeys: String, CodingKey {
        case firstName = "first_name"
//            case lastName = "last_name"
        case profileImage = "profile_image"
        case phoneNumber = "phone_number"
//            case birthDay
        case isHost = "is_host"
    }

    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: Codingkeys.self)
        self.firstName = try value.decode(String.self, forKey: .firstName)
//            self.lastName = try value.decode(String.self, forKey: .lastName)
        self.profileImage = try value.decode(String.self, forKey: .profileImage)
        self.phoneNumber = try value.decode(String.self, forKey: .phoneNumber)
//            self.birthDay = try value.decode(String.self, forKey: .birthDay)
        self.isHost = try value.decode(Bool.self, forKey: .isHost)
    }
}
    //

}
//
