//
//  About.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/6/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

class About: NSObject, Codable {

    let type: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case type
        case content
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        content = try values.decode(String.self, forKey: .content)
    }

    func getType() -> AboutType {
        return AboutType.typeFromSearver(type)
    }

}
