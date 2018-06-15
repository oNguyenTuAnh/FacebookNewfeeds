//
//  LikePopOverViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/12/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class LikePopoverViewController: UIViewController {

    @IBOutlet weak var emojiStackView: UIStackView!
    var selectEmojiClosure: ((UIImageView, UITapGestureRecognizer) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTap(_:)))
        emojiStackView.addGestureRecognizer(tapGesture)
    }

    @objc private func actionTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: emojiStackView)
        if let imageView = getViewWithPoint(point) as? UIImageView, let action = selectEmojiClosure {
            action(imageView, gesture)
            dismiss(animated: true, completion: nil)
        }
    }

    private func getViewWithPoint(_ point: CGPoint) -> UIView? {
        var view: UIView? = nil
        for subview in emojiStackView.subviews {
            if subview.frame.contains(point) {
                view = subview
                break
            }
        }
        return view
    }

}
