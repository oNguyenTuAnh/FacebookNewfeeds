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
    @IBOutlet weak var photoStackView: UIStackView!
    @IBOutlet weak var heightPhotoStackViewLayout: NSLayoutConstraint!
    @IBOutlet weak var likeButton: UIButton!

    var feedData: Feeds?

    var actionClickProfile: (() -> Void)?
    var layoutType = PhotoLayoutType.horizontal {
        didSet {
            if layoutType == .horizontal {
                photoStackView.axis = .horizontal
            } else if layoutType == .vertical {
                photoStackView.axis = .vertical
            }
            subStackView.axis = layoutType.getStackViewAxisLayout()
        }
    }

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
        let likeLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showProfile(_:)))
        likeButton.addGestureRecognizer(likeLongPressGesture)
    }

    func bindingData(_ feed: Feeds?) {
        feedData = feed
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
        photoStackView.removeAllSubviews()
        subStackView.removeAllSubviews()
        if let imgFeed = feed?.feedImages, imgFeed.count > 0 {
            heightPhotoStackViewLayout.constant = 300.0
            bindingPhoto(imgFeed)
        } else {
            heightPhotoStackViewLayout.constant = 0.0
        }
    }

    private func bindingPhoto(_ photos: [String]) {
        updateLayoutPhoto(photos)

        if photos.count <= 2 {
            for photo in photos {
                photoStackView.addArrangedSubview(creatImageView(photo))
            }
        } else if photos.count <= 4 {
            for (index, photo) in photos.enumerated() {
                if index == 0 {
                    photoStackView.addArrangedSubview(creatImageView(photo))
                    photoStackView.addArrangedSubview(subStackView)
                } else {
                    subStackView.addArrangedSubview(creatImageView(photo))
                }
            }
        } else {
            let number: Int = photos.count - 4
            for (index, photo) in photos[0..<4].enumerated() {
                if index == 0 {
                    photoStackView.addArrangedSubview(creatImageView(photo))
                    photoStackView.addArrangedSubview(subStackView)
                } else if index == 3 {
                    subStackView.addArrangedSubview(creatImageView(photo, numberHiden: number))
                } else {
                    subStackView.addArrangedSubview(creatImageView(photo))
                }
            }
        }
    }

    private func creatImageView(_ photo: String, numberHiden: Int = 0) -> UIView {
        guard let photoView = ItemPhotoView.initWithDefaultNib() else {
            return UIView()
        }
        if numberHiden != 0 {
            photoView.bindingData(photo, isMore: true, numberHiden: numberHiden)
        } else {
            photoView.bindingData(photo)
        }
        photoView.actionTapPhotoClosure = {
            print(photo)
        }
        return photoView
    }

    private func updateLayoutPhoto(_ photos: [String]) {
        UIImage.downloadedFrom(link: photos[0], completion: { [weak self] (image) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.layoutType = image.size.height > image.size.width ? .horizontal : .vertical
        })
    }

    //MARK: Profile
    @objc func showProfile(_ gesture: UITapGestureRecognizer) {
        if let action = actionClickProfile {
            action()
        }
    }

    //MARK: Like
    @IBAction func actionLike(_ sender: UIButton) {
        //TODOs: like
    }

    @objc func showEmoji(_ gesture: UILongPressGestureRecognizer) {
        //TODOs: Show popover emoji
    }

}
