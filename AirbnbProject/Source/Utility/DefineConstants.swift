//
//  DefineConstants.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 7..
//  Copyright © 2018년 김승진. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "https://leesoo.kr"
    
    enum Auth {
        static let login = API.baseURL + "/members/login/"
        static let facebookLogin = API.baseURL + "/members/facebooklogin/"
        static let signUp = API.baseURL + "/members/signup/"
        static let loginOut = API.baseURL + "/members/logout"
        static let emailCheck = API.baseURL + "/members/emailcheck/"
        static let findPassword = API.baseURL + "/members/sendmail/"
        static let logout = API.baseURL + "/members/logout"
    }
    
    enum UserInfo {
        static let fetchProfile = API.baseURL + "/members/profile/"
    }

    enum MainPage {
        static let getRoomList = API.baseURL + "/rooms/main/"
        static let getTotalRoomList = API.baseURL + "/rooms/list?address_city="
        static let getTotalRoomListInKorea = API.baseURL + "/rooms/list/"
        static let getSearchResultByKeyword = API.baseURL + "/rooms/list/?search="
    }

    enum RoomDetail {
        static let detailInfo = API.baseURL + "/rooms/main/"
    }
    
    enum RoomLike {
        static let likeList = API.baseURL + "/members/likes/"
        static let likeListAddDelete = API.baseURL + "/rooms/list/"
    }

}
