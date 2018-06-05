//
//  APIServices.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/30/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

enum Result {
    case success(Data)
    case error(String)
}

class APIServices {

    static let shareInstance = APIServices()

    private init() {}

    private lazy var sessionConfiguration: URLSessionConfiguration = {
        let sessionConfigure = URLSessionConfiguration.default
        sessionConfigure.allowsCellularAccess = true
        sessionConfigure.timeoutIntervalForRequest = 30.0
        return sessionConfigure
    }()

    private lazy var session: URLSession = {
        let session = URLSession(configuration: self.sessionConfiguration)
        return session
    }()

    func startRequest(request: URLRequest, completionHandle: @escaping (Result) -> Void ) {
        session.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                return completionHandle(.error(error?.localizedDescription ?? "Can not request to end point"))
            }
            if let resultData = data {
                completionHandle(.success(resultData))
            } else {
                return completionHandle(.error("No data for this request"))
            }
        }.resume()
    }

}
