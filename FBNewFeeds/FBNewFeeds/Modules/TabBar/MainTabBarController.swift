//
//  MainTabBarController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

private struct Constants {

    static let imgNewsfeed = UIImage(named: "ic-news-feed")
    static let imgNotify   = UIImage(named: "ic-notify")
    static let imgFriend   = UIImage(named: "ic-friend")
    static let imgMenu     = UIImage(named: "ic-menu")

}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }

    private func setupTabbar() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        var listViewController: [UIViewController] = []
        let newsfeedViewController = BaseNavigationController(
            rootViewController: NewsfeedViewController.instantiateFromNib())
        newsfeedViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgNewsfeed,
            selectedImage: Constants.imgNewsfeed?.imageWithColor(color: AppColor.blueColor()))
        listViewController.append(newsfeedViewController)

        let notifyViewController = NotifyViewController.instantiateFromNib()
        notifyViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgNotify,
            selectedImage: Constants.imgNotify?.imageWithColor(color: AppColor.blueColor()))
        listViewController.append(notifyViewController)

        let friendViewController = NotifyViewController.instantiateFromNib()
        friendViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgFriend,
            selectedImage: Constants.imgFriend?.imageWithColor(color: AppColor.blueColor()))
        listViewController.append(friendViewController)

        let menuViewController = NotifyViewController.instantiateFromNib()
        menuViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgMenu,
            selectedImage: Constants.imgMenu?.imageWithColor(color: AppColor.blueColor()))
        listViewController.append(menuViewController)

        for item in listViewController {
            item.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }

        viewControllers = listViewController
    }

}
