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

    func showPopoverEmoji(_ view: UIView, _ completion: ((Int) -> Void)?) {
        let emojiView = LikePopoverViewController.instantiateFromNib()
        emojiView.modalPresentationStyle = .popover
        emojiView.preferredContentSize = CGSize(width: 250, height: 45)
        emojiView.selectEmojiClosure = { [weak self] (imageView, gesture) in
            self?.animationImage(imageView, gesture, completion)
        }
        let popoverView = emojiView.popoverPresentationController
        popoverView?.delegate = self
        popoverView?.sourceView = view
        popoverView?.sourceRect = view.bounds
        popoverView?.permittedArrowDirections = [.up, .down]
        popoverView?.backgroundColor = .clear
        present(emojiView, animated: true, completion: nil)
    }

    func animationImage(_ imgView: UIImageView, _ gesture: UITapGestureRecognizer, _ completion: ((Int) -> Void)?) {
        let imageView = UIImageView(image: imgView.image)
        imageView.contentMode = .scaleAspectFit
        let point = gesture.location(in: view)
        imageView.center = point
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.moveEmojiSelected()
        imageView.transformEmojiSelected()
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            imageView.removeFromSuperview()
            completion?(imgView.tag)
        }
    }

    func updateLikeOfCell(_ tableView: UITableView, _ indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell {
            cell.updateLikeButton()
        }
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

extension BaseViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
