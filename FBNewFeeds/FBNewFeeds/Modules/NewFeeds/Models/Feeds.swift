//
//  Feeds.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/39/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

class Feeds: NSObject, Codable {

    let fullName: String?
    let avatarUrl: String?
    let createAt: String?
    let feedContent: String?
    let visibleMode: String?
    let reactionCount: Int?
    let commentCount: Int?
    let sharingCount: Int?
    let feedImages: [String]?
    var isLike = false

    enum CodingKeys: String, CodingKey {
        case fullName
        case avatarUrl
        case createAt
        case feedContent
        case visibleMode
        case reactionCount
        case commentCount
        case sharingCount
        case feedImages
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        createAt = try values.decodeIfPresent(String.self, forKey: .createAt)
        feedContent = try values.decodeIfPresent(String.self, forKey: .feedContent)
        visibleMode = try values.decodeIfPresent(String.self, forKey: .visibleMode)
        reactionCount = try values.decodeIfPresent(Int.self, forKey: .reactionCount)
        commentCount = try values.decodeIfPresent(Int.self, forKey: .commentCount)
        sharingCount = try values.decodeIfPresent(Int.self, forKey: .sharingCount)
        feedImages = try values.decodeIfPresent([String].self, forKey: .feedImages)
    }

    func like() {
        isLike = !isLike
    }

}
