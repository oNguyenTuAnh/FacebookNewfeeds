//
//  Newsfeed.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/39/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

class Newsfeed: Codable {

	let stories: [Stories]?
	let feeds: [Feeds]?

	enum CodingKeys: String, CodingKey {
		case stories
		case feeds
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		stories = try values.decodeIfPresent([Stories].self, forKey: .stories)
		feeds = try values.decodeIfPresent([Feeds].self, forKey: .feeds)
	}

}
