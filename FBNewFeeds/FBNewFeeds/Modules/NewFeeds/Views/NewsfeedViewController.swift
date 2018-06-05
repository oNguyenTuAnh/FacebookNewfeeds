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
    let cellIdentifier = "feelCell"
    let heightHeaderTableView: CGFloat = 90.0

    lazy var storyView: StoryView? = {
        let view = StoryView.initWithDefaultNib()
        view?.frame = CGRect(x: 0, y: 0, width: newsFeedTableView.bounds.width, height: heightHeaderTableView)
        return view
    }()

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
        newsFeedTableView.register(FeedTableViewCell.nibDefault(), forCellReuseIdentifier: cellIdentifier)
        if let headerView = storyView {
            let tableViewHeader = UIView(frame: headerView.frame)
            tableViewHeader.addSubview(headerView)
            newsFeedTableView.tableHeaderView = tableViewHeader
        }
    }

    func getData() {
        let progressView = showActivityIndicatory(onView: view)
        viewModel.getData {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.removeActivityIndicatory(indicatorView: progressView)
            if error == nil {
                strongSelf.refreshView()
            }
        }
    }

    func refreshView() {
        newsFeedTableView.reloadData()
        storyView?.reloadData(viewModel.getStoryData())
    }

    func showProfile() {
        navigationController?.pushViewController(ProfileViewController.instantiateFromNib(), animated: true)
    }

}

extension NewsfeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            as? FeedTableViewCell else {
                return UITableViewCell()
        }
        let feedItem = viewModel.getNewsFeedAtIndex(indexPath.row)
        cell.bindingData(feedItem)
        cell.selectionStyle = .none
        cell.actionClickProfile = { [weak self] () in
            guard let strongSelf = self else {
                return
            }
            strongSelf.showProfile()
        }
        return cell
    }

}

extension NewsfeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberRowNewsFeed()
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

}
