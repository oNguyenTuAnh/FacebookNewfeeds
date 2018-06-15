//
//  NewfeedsViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class NewsfeedViewController: BaseViewController {

    @IBOutlet weak var newsFeedTableView: UITableView!

    let viewModel = NewsFeedViewModel()
    let cellStoriesIdentifier = "storiesCell"
    let cellNewsFeedIdentifier = "newsFeelCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    func setupView() {
        addSearchBarToNavigationItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-camera"),
            style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-messenger"),
            style: .plain, target: nil, action: nil)
        newsFeedTableView.register(StoriesTableViewCell.nibDefault(), forCellReuseIdentifier: cellStoriesIdentifier)
        newsFeedTableView.register(FeedTableViewCell.nibDefault(), forCellReuseIdentifier: cellNewsFeedIdentifier)
    }

    func getData() {
        let progressView = showActivityIndicatory(onView: view)
        viewModel.getData {[weak self] (error) in
            self?.removeActivityIndicatory(indicatorView: progressView)
            if error == nil {
                self?.refreshView()
            }
        }
    }

    func refreshView() {
        newsFeedTableView.reloadData()
    }

    func showProfile() {
        navigationController?.pushViewController(ProfileViewController.instantiateFromNib(), animated: true)
    }

    func showPopoverEmoji(_ view: UIView, _ index: IndexPath) {
        let emojiView = LikePopoverViewController.instantiateFromNib()
        emojiView.modalPresentationStyle = .popover
        emojiView.preferredContentSize = CGSize(width: 246, height: 40)
        emojiView.selectEmojiClosure = { [weak self] (imageView, gesture) in
            self?.animationImage(imageView, gesture, index)
        }
        let popoverView = emojiView.popoverPresentationController
        popoverView?.delegate = self
        popoverView?.sourceView = view
        popoverView?.sourceRect = view.bounds
        popoverView?.permittedArrowDirections = [.up, .down]
        popoverView?.backgroundColor = .clear
        present(emojiView, animated: true, completion: nil)
    }

    func animationImage(_ imgView: UIImageView, _ gesture: UITapGestureRecognizer, _ index: IndexPath) {
        let imageView = UIImageView(image: imgView.image)
        imageView.contentMode = .scaleAspectFit
        let point = gesture.location(in: view)
        imageView.center = point
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.moveEmojiSelected()
        imageView.transformEmojiSelected()
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            imageView.removeFromSuperview()
            self?.viewModel.setLikedForFeedAtIndex(index)
            self?.updateLikeOfCell(index)
        }
    }

}

extension NewsfeedViewController {

    func updateLikeOfCell(_ indexPath: IndexPath) {
        if let cell = newsFeedTableView.cellForRow(at: indexPath) as? FeedTableViewCell {
            cell.updateLikeButton()
        }
    }

}

extension NewsfeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isSectionStories(indexPath) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellStoriesIdentifier)
                as? StoriesTableViewCell else {
                    return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.bindingData(viewModel.getStoryData())
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellNewsFeedIdentifier)
                as? FeedTableViewCell else {
                    return UITableViewCell()
            }
            let feedItem = viewModel.getNewsFeedAtIndex(indexPath.row)
            cell.bindingData(feedItem)
            cell.selectionStyle = .none
            cell.actionClickProfile = { [weak self] in
                self?.showProfile()
            }
            cell.longPressLikeAction = { [weak self] (view) in
                self?.showPopoverEmoji(view, indexPath)
            }
            return cell
        }
    }

}

extension NewsfeedViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberRowOfSection(section)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightTableViewCell(indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }

}

extension NewsfeedViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
