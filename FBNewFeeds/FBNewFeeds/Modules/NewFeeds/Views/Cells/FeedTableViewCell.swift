//
//  FeedTableViewCell.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/30/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var numberLike: UILabel!
    @IBOutlet weak var numberComment: UILabel!
    @IBOutlet weak var numberShare: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var createAt: UILabel!

    var actionClickProfile: (() -> Void)?

    lazy var subStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        return stackView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        let avatarTabGesture = UITapGestureRecognizer(target: self, action: #selector(showProfile(_:)))
        let nameTabGesture = UITapGestureRecognizer(target: self, action: #selector(showProfile(_:)))
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(avatarTabGesture)
        fullName.isUserInteractionEnabled = true
        fullName.addGestureRecognizer(nameTabGesture)
    }

    func bindingData(_ feed: Feeds?) {
        if let avatarUrl = feed?.avatarUrl {
            avatar.downloadedFrom(link: avatarUrl)
        }
        fullName.text = feed?.fullName
        if let like = feed?.reactionCount {
            numberLike.text = like.abbreviated
        }
        if let comment = feed?.commentCount {
            numberComment.text = comment.abbreviated
        }
        if let share = feed?.sharingCount {
            numberShare.text = share.abbreviated
        }
        content.text = feed?.feedContent

        if let dateString = feed?.createAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: dateString) {
                 createAt.text = date.timestampString
            }
        }
    }

    @objc func showProfile(_ gesture: UITapGestureRecognizer) {
        if let action = actionClickProfile {
            action()
        }
    }

}
