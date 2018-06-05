//
//  BaseViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/1/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //extendedLayoutIncludesOpaqueBars = true
    }

    func addSearchBarToNavigationItem() {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search"
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.fromHex("253E68")
        textFieldInsideSearchBar?.textColor = .white
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        }
        navigationItem.titleView = searchBar
    }
}
