//
//  LoginViewController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginAction(_ sender: UIButton) {
        guard let account = accountName.text, let pass = password.text else {
            return
        }
        if account == "abc" && pass == "123" {
            Utilities.changeRootViewController(MainTabBarController())
        } else {
            // TODOs: Login fail
        }
    }

}
