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
    let newsfeedCellIdentifier = "feelCell"
    let profileCellIdentifier = "profileCell"
    let sectionProfile: Int = 0
    let sectionNewsFeed: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    private func setupView() {
        addSearchBarToNavigationItem()
        profileTableView.register(ProfileTableViewCell.nibDefault(), forCellReuseIdentifier: profileCellIdentifier)
        profileTableView.register(FeedTableViewCell.nibDefault(), forCellReuseIdentifier: newsfeedCellIdentifier)
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
        profileTableView.reloadData()
    }

    func showProfile() {
        navigationController?.pushViewController(ProfileViewController.instantiateFromNib(), animated: true)
    }

}

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sectionProfile {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier)
                as? ProfileTableViewCell else {
                    return UITableViewCell()
            }
            cell.bindingData(viewModel.getProfile())
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsfeedCellIdentifier)
                as? FeedTableViewCell else {
                    return UITableViewCell()
            }
            cell.bindingData(viewModel.getNewsFeedAtIndex(indexPath.row))
            cell.selectionStyle = .none
            cell.actionClickProfile = { [weak self] () in
                self?.showProfile()
            }
            return cell
        }
    }

}

extension ProfileViewController: UITableViewDelegate {

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
