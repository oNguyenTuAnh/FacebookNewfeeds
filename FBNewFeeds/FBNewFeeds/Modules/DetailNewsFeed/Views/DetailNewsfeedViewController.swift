//
//  DetailNewsfeedViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/15/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class DetailNewsfeedViewController: BaseViewController {

    fileprivate struct Constraint {
        static let radius: CGFloat = 10
        static let borderWidth: CGFloat = 0.5
        static let paddingTextView = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let duration = 0.4
    }

    @IBOutlet weak var detailNewsFeedTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var paddingBottomLayout: NSLayoutConstraint!

    let viewModel = DetailNewsfeedViewModel()
    let newsfeedCellIdentifier = "feelCell"
    let commentCellIdentifier = "commentCell"
    let sectionProfile: Int = 0
    let sectionNewsFeed: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        addSearchBarToNavigationItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-messenger"),
            style: .plain, target: nil, action: nil)
        detailNewsFeedTableView.register(FeedTableViewCell.nibDefault(), forCellReuseIdentifier: newsfeedCellIdentifier)
        detailNewsFeedTableView.register(CommentTableViewCell.nibDefault(),
            forCellReuseIdentifier: commentCellIdentifier)
        commentTextView.layer.cornerRadius = Constraint.radius
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = Constraint.borderWidth
        commentTextView.textContainerInset = Constraint.paddingTextView
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)),
            name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)),
            name: .UIKeyboardWillHide, object: nil)
    }

    fileprivate func showProfile() {
        navigationController?.pushViewController(ProfileViewController.instantiateFromNib(), animated: true)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let heightTabbar = tabBarController?.tabBar.frame.height {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: Constraint.duration) {
                self.paddingBottomLayout.constant = keyboardHeight - heightTabbar
            }
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: Constraint.duration) {
            self.paddingBottomLayout.constant = 0
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

}

extension DetailNewsfeedViewController {

    static func viewController(_ feed: Feeds?) -> DetailNewsfeedViewController {
        let viewController = DetailNewsfeedViewController.instantiateFromNib()
        viewController.viewModel.setFeed(feed)
        return viewController
    }

}

extension DetailNewsfeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sectionProfile {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsfeedCellIdentifier)
                as? FeedTableViewCell else {
                    return UITableViewCell()
            }
            cell.bindingData(viewModel.getFeed(), paddingtop: 0)
            cell.selectionStyle = .none
            cell.actionClickProfile = { [weak self] () in
                self?.showProfile()
            }
            cell.longPressLikeAction = { [weak self] (view) in
                self?.showPopoverEmoji(view, { [weak self] (tag) in
                    self?.viewModel.setLikedForFeed(tag)
                    self?.updateLikeOfCell(tableView, indexPath)
                })
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier)
                as? CommentTableViewCell else {
                    return UITableViewCell()
            }
            cell.bindingData(viewModel.getCommentAtIndex(indexPath))
            cell.selectionStyle = .none
            return cell
        }
    }

}

extension DetailNewsfeedViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberRowOfSection(section: section)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

}
