//
//  LoginVC.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 8/11/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController, Storyboarded {
    // MARK: - IBOutlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Private variable
    let bag = DisposeBag()
    let viewModel = AuthenticateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRx()
        setupUI()
    }

    // MARK: - Private method
    private func setupRx() {
        loginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
                guard let `self` = self else { return }

                if let username = self.usernameTextField.text,
                    let pass = self.passwordTextField.text {
                    self.viewModel.login(username: username, pass: pass)
                }
            })
            .disposed(by: bag)
    }

    private func setupUI() {
        self.title = "Login"
    }
}


