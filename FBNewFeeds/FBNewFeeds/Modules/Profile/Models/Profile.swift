//
//  Profile.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/6/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

class Profile: NSObject, Codable {

    let name: String
    let avatar: String?
    let background: String?
    let isFriend: Bool
    let abouts: [About]

    enum CodingKeys: String, CodingKey {
        case name
        case avatar
        case background
        case isFriend
        case abouts
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        background = try values.decodeIfPresent(String.self, forKey: .background)
        isFriend = try values.decode(Bool.self, forKey: .isFriend)
        abouts = try values.decode([About].self, forKey: .abouts)
    }

}
