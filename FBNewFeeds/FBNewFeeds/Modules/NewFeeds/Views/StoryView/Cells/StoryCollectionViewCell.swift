//
//  StoryCollectionViewCell.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/31/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        avatarView.layer.cornerRadius = avatarView.bounds.height / 2
        avatarView.layer.borderColor = AppColor.blueColor().cgColor
        avatarView.layer.borderWidth = 1
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        avatarImage.layer.borderColor = UIColor.gray.cgColor
        avatarImage.layer.borderWidth = 0.5
    }

    func binding(_ data: Stories) {
        if let avatarUrl = data.storyImageUrl {
            avatarImage.downloadedFrom(link: avatarUrl)
        }
        nameLabel.text = data.fullName
    }

}
