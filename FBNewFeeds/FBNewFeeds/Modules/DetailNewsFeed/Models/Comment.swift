//
//  Comment.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/15/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class Comment: NSObject, Codable {

    var avatarUrl: String?
    var content: String?
    var likeNumer: Int?

    init(_ avatar: String, _ contentCmt: String) {
        avatarUrl = avatar
        content = contentCmt
    }

    enum CodingKeys: String, CodingKey {
        case avatarUrl
        case content
        case likeNumer
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        likeNumer = try values.decodeIfPresent(Int.self, forKey: .likeNumer)
    }

}
