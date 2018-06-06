//
//  ProfileViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profileTableView: UITableView!

    let viewModel = ProfileViewModel()
    let cellIdentifier = "feelCell"

    lazy var aboutHeader: ProfileHeaderView? = {
        let view = ProfileHeaderView.initWithDefaultNib()
        view?.frame = CGRect(x: 0, y: 0, width: profileTableView.bounds.width, height: 500)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    private func setupView() {
        addSearchBarToNavigationItem()
        profileTableView.register(FeedTableViewCell.nibDefault(), forCellReuseIdentifier: cellIdentifier)
        if let headerTable = aboutHeader {
            let tableViewHeader = UIView(frame: CGRect(x: 0, y: 0, width: headerTable.bounds.width,
                height: headerTable.bounds.height))
            headerTable.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            tableViewHeader.addSubview(headerTable)
            profileTableView.tableHeaderView = tableViewHeader
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
        profileTableView.reloadData()
        aboutHeader?.reloadData(viewModel.getProfile())
    }

    func showProfile() {
        navigationController?.pushViewController(ProfileViewController.instantiateFromNib(), animated: true)
    }

}

extension ProfileViewController: UITableViewDataSource {

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

extension ProfileViewController: UITableViewDelegate {

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
