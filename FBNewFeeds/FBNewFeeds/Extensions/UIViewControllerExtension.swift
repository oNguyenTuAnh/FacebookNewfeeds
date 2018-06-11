//
//  ViewControllerExtension.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

extension UIViewController {

    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib(self)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func showActivityIndicatory(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.backgroundColor = AppColor.backgroupActivityColor
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        DispatchQueue.main.async {
            spinnerView.addSubview(indicatorView)
            onView.addSubview(spinnerView)
            let viewsDict = ["spinner": spinnerView, "aiView": indicatorView]
            var horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[spinner]|",
                options: [], metrics: nil, views: viewsDict)
            onView.addConstraints(horizontalConstraints)
            var verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[spinner]|",
                options: [], metrics: nil, views: viewsDict)
            onView.addConstraints(verticalConstraints)

            horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[aiView]|",
                options: [], metrics: nil, views: viewsDict)
            spinnerView.addConstraints(horizontalConstraints)
            verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[aiView]|",
                options: [], metrics: nil, views: viewsDict)
            spinnerView.addConstraints(verticalConstraints)
        }
        return spinnerView
    }

    func removeActivityIndicatory(indicatorView: UIView) {
        DispatchQueue.main.async {
            indicatorView.removeFromSuperview()
        }
    }

}
