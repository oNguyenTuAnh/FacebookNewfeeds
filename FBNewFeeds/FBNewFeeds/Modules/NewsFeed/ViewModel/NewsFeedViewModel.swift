//
//  NewsFeedViewModel.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/30/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class NewsFeedViewModel: NSObject {

    private var backgroundQueue = OperationQueue()
    private weak var mainQueue = OperationQueue.main
    var newsFeeds: Newsfeed?
    let sectionStories = 0
    let sectionNewsFeed = 1
    let heightStoriesTableViewCell: CGFloat = 90.0

    override init() {
        backgroundQueue.maxConcurrentOperationCount = 1
    }

    func getData(completion: @escaping (_ error: String?) -> Void) {
        backgroundQueue.addOperation {
            guard let request = APIRequestProvider.shareInstance.newsFeedRequest() else {
                return
            }
            APIServices.shareInstance.startRequest(request: request) { [weak self] (result) in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    do {
                        let newsFeed = try jsonDecoder.decode(Newsfeed.self, from: data)
                        strongSelf.setDataNewsfeed(newsFeed)
                        strongSelf.mainQueue?.addOperation {
                            completion(nil)
                        }
                    } catch let error {
                        strongSelf.mainQueue?.addOperation {
                            completion(error.localizedDescription)
                        }
                    }
                case .error(let errorString):
                    strongSelf.mainQueue?.addOperation {
                        completion(errorString)
                    }
                }
            }
        }
    }

    // MARK: SET METHOD
    func setDataNewsfeed(_ data: Newsfeed) {
        newsFeeds = data
    }

    func setLikedForFeedAtIndex(_ index: IndexPath, _ tag: Int) {
        newsFeeds?.feeds?[index.row].updateEmoji(tag)
    }

    // MARK: GET METHOD
    func getNumberSection() -> Int {
        return 2
    }

    func getNumberRowOfSection(_ section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return newsFeeds?.feeds?.count ?? 0
    }

    func getNewsFeedAtIndex(_ index: IndexPath) -> Feeds? {
        return newsFeeds?.feeds?[index.row]
    }

    func getStoryData() -> [Stories] {
        if let stories = newsFeeds?.stories {
            return stories
        }
        return []
    }

    func isSectionStories(_ index: IndexPath) -> Bool {
        return index.section == sectionStories
    }

    func getHeightTableViewCell(_ index: IndexPath) -> CGFloat {
        return isSectionStories(index) ? heightStoriesTableViewCell : UITableViewAutomaticDimension
    }
}
