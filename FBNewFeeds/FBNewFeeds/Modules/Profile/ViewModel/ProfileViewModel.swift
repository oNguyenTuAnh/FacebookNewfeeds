//
//  ProfileViewModel.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/6/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class ProfileViewModel: NSObject {

    private var backgroundQueue = OperationQueue()
    private weak var mainQueue = OperationQueue.main
    var profileModel: ProfileModel?

    override init() {
        backgroundQueue.maxConcurrentOperationCount = 1
    }

    func getData(completion: @escaping (_ error: String?) -> Void) {
        backgroundQueue.addOperation {
            guard let request = APIRequestProvider.shareInstance.profileRequest() else {
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
                        let profile = try jsonDecoder.decode(ProfileModel.self, from: data)
                        strongSelf.setDataProdile(profile)
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

    func setDataProdile(_ data: ProfileModel) {
        profileModel = data
    }

    func getNumberSections() -> Int {
        return 2
    }

    func getNumberRowOfSection(section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return profileModel?.feeds?.count ?? 0
    }

    func getNewsFeedAtIndex(_ index: Int) -> Feeds? {
        return profileModel?.feeds?[index]
    }

    func getProfile() -> Profile? {
        return profileModel?.profile
    }

}
