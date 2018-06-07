//
//  AboutTableViewCell.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/6/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    @IBOutlet weak var iconAbout: UIImageView!
    @IBOutlet weak var captionAbout: UILabel!
    @IBOutlet weak var contentAbout: UILabel!

    func bindingData(_ data: About) {
        let itemData = data.getType().getCaptionAndIcon()
        iconAbout.image = itemData?.icon
        captionAbout.text = itemData?.caption
        contentAbout.text = data.content
    }

}
