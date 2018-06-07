//
//  ProfileTableViewCell.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/6/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutTableView: UITableView!
    @IBOutlet weak var heightAboutViewLayout: NSLayoutConstraint!

    let aboutCellIdentifier = "aboutCell"
    let heightCellAbout: CGFloat = 30.0
    var abouts: [About] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        avatarView.layer.cornerRadius = 3.0
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.borderWidth = 2.0
        avatarView.layer.shadowColor = UIColor.lightGray.cgColor
        avatarView.layer.shadowRadius = 3.0
        avatarView.layer.opacity = 1
        avatarView.layer.shadowOffset = .zero
        aboutTableView.delegate = self
        aboutTableView.dataSource = self
        aboutTableView.register(AboutTableViewCell.nibDefault(), forCellReuseIdentifier: aboutCellIdentifier)
    }

    func bindingData(_ data: Profile?) {
        nameLabel.text = data?.name
        if let background = data?.background {
            backgroundImage.downloadedFrom(link: background, contentMode: .scaleToFill)
        }
        if let avatar = data?.avatar {
            avatarImage.downloadedFrom(link: avatar, contentMode: .scaleToFill)
        }
        if let aboutData = data?.abouts {
            abouts = aboutData
            heightAboutViewLayout.constant = CGFloat(aboutData.count) * heightCellAbout
            aboutTableView.reloadData()
        } else {
            heightAboutViewLayout.constant = 0.0
        }
    }

}

extension ProfileTableViewCell: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: aboutCellIdentifier)
            as? AboutTableViewCell else {
                return UITableViewCell()
        }
        cell.bindingData(abouts[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

}

extension ProfileTableViewCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abouts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCellAbout
    }

}
