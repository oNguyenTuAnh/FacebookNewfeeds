//
//  DetailNewsfeedViewModel.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/15/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class DetailNewsfeedViewModel: NSObject {

    private var feed: Feeds?

    // MARK: SET METHOD
    func setFeed(_ data: Feeds?) {
        feed = data
    }

    // MARK: GET METHOD
    func getFeed() -> Feeds? {
        return feed
    }

    func getNumberSections() -> Int {
        return 2
    }

    func setLikedForFeed(_ tag: Int) {
        feed?.updateEmoji(tag)
    }

    func getNumberRowOfSection(section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return feed?.comment?.count ?? 0
    }

    func getCommentAtIndex(_ index: IndexPath) -> Comment? {
        return feed?.comment?[index.row]
    }

}
