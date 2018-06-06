//
//  ProfileModel.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/6/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

class ProfileModel: NSObject, Codable {

    let profile: Profile?
    let feeds: [Feeds]?

    enum CodingKeys: String, CodingKey {
        case profile
        case feeds
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profile = try values.decodeIfPresent(Profile.self, forKey: .profile)
        feeds = try values.decodeIfPresent([Feeds].self, forKey: .feeds)
    }

}
