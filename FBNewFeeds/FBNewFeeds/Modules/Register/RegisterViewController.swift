//
//  RegisterViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/29/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupView()
    }

    func setupView() {
        let rightButtonBar = UIBarButtonItem(barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismisView(_:)))
        navigationItem.rightBarButtonItem = rightButtonBar
    }

    @objc  func dismisView(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func registerAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
