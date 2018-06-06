//
//  profileHeaderView.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/1/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

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
    }

    func reloadData(_ data: Profile?) {
        nameLabel.text = data?.name
        if let background = data?.background {
            backgroundImage.downloadedFrom(link: background, contentMode: .scaleToFill)
        }
        if let avatar = data?.avatar {
            avatarImage.downloadedFrom(link: avatar, contentMode: .scaleToFill)
        }
    }

}

extension ProfileHeaderView {

    class func initWithDefaultNib() -> ProfileHeaderView? {
        let list = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        let view = list?.first as? ProfileHeaderView
        return view
    }

}
