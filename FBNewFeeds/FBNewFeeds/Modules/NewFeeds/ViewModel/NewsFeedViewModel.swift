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

    func setDataNewsfeed(_ data: Newsfeed) {
        newsFeeds = data
    }

    func getNumberRowNewsFeed() -> Int {
        if let count = newsFeeds?.feeds?.count {
            return count
        }
        return 0
    }

    func getNewsFeedAtIndex(_ index: Int) -> Feeds? {
        return newsFeeds?.feeds?[index]
    }

    func getStoryData() -> [Stories] {
        if let stories = newsFeeds?.stories {
            return stories
        }
        return []
    }

}
