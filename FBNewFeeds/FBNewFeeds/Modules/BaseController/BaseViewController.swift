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
    }

    func addSearchBarToNavigationItem() {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = AppColor.searchBarColor
        textFieldInsideSearchBar?.textColor = .white
        navigationItem.titleView = searchBar
    }

}

extension BaseViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(SearchViewController.instantiateFromNib(), animated: false)
        }
        return false
    }

}
