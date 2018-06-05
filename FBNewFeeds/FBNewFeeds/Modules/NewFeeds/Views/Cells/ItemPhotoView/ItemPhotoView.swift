//
//  ItemPhotoView.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/4/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class ItemPhotoView: UIView {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var numberButton: UIButton!

    var actionTapPhotoClosure: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func actionTapPhoto(_ sender: UIButton) {
        if let action = actionTapPhotoClosure {
            action()
        }
    }

    func bindingData(_ link: String, isMore: Bool = false, numberHiden: Int = 0) {
        photoImageView.downloadedFrom(link: link, contentMode: .scaleAspectFill)
        if isMore {
            numberButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            numberButton.setTitle("+ \(numberHiden)", for: .normal)
        } else {
            numberButton.backgroundColor = UIColor.clear
            numberButton.setTitle("", for: .normal)
        }
    }
}

extension ItemPhotoView {

    class func initWithDefaultNib() -> ItemPhotoView? {
        let list = Bundle.main.loadNibNamed("ItemPhotoView", owner: self, options: nil)
        let view = list?.first as? ItemPhotoView
        return view
    }

}
