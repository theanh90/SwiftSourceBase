//
//  ViewController.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/21/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize

class ViewController: UIViewController {
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var languagesSwitch: UISwitch!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    // MARK: - Private variable
    let bag = DisposeBag()
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // multiple target
        displayServer()
        
        // Localize
        greetingLabel.text = "greeting".localize()
        
        // RxSwift
        setupRx()
    }

    // MARK: - Private method
    private func displayServer() {
        #if DEV
            serverLabel.text = "This is DEV server"
        #elseif STG
            serverLabel.text = "This is STAGING server"
        #else
            serverLabel.text = "This is PRODUCTION server"
        #endif
    }
    
    private func setupRx() {
        languagesSwitch.rx.isOn.changed
            .subscribe(onNext: { [weak self] (isOn) in
                guard let `self` = self else { return }
                
                self.localizeToggle(isVietnamese: isOn)
            })
            .disposed(by: bag)
        
        // Call API
        getButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] (_) in
                WindowPopup.showLoading()
                self?.viewModel.getUserInfo()
            })
            .disposed(by: bag)
        
        postButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] (_) in
                WindowPopup.showLoading()
                self?.viewModel.addNewUser()
            })
            .disposed(by: bag)
        
        // Receive data
        viewModel.errorString.subscribe(onNext: { (error) in
            WindowPopup.hideLoading()
            Logger.error(error)
        })
        .disposed(by: bag)
        
        viewModel.userInfo.subscribe(onNext: { (user) in
            WindowPopup.hideLoading()
            Logger.info("---xxx Ok roi: \(user)")
        })
        .disposed(by: bag)
        
        viewModel.newUser.subscribe(onNext: { (newUser) in
            WindowPopup.hideLoading()
            Logger.info("---xxx Add successfully roi: \(newUser)")
        })
        .disposed(by: bag)
    }
    
    private func localizeToggle(isVietnamese: Bool) {
        if isVietnamese {
            Localize.update(language: "vi-VN")
        } else {
            Localize.update(language: "en")
        }
    }
}

