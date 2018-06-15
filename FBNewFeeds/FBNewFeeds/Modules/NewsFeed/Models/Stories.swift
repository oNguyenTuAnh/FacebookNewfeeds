//
//  Stories.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/39/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

class Stories: Codable {

	let storyImageUrl: String?
	let fullName: String?

	enum CodingKeys: String, CodingKey {
		case storyImageUrl
		case fullName
	}

	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		storyImageUrl = try values.decodeIfPresent(String.self, forKey: .storyImageUrl)
		fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
	}

}
