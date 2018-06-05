//
//  APIRequestProvider.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/30/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class APIRequestProvider {

    static let shareInstance = APIRequestProvider()
    private init() {}

    func newsFeedRequest() -> URLRequest? {
        guard let url = URL(string: "https://www.mocky.io/v2/5b0ce0cb3300005100b400f1") else {
            return nil
        }
        return URLRequest(url: url)
    }

}
