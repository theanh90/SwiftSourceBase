//
//  AlertVC.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/7/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlertVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    // MARK: - Private variable
    let bag = DisposeBag()
    
    // MARK: - Public variable
    var yesBlock: EmptyClosure?
    var noBlock: EmptyClosure?
    var titleAlert: String?
    var contentAlert: String!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRx()
        showContent()
    }
    
    // MARK: - Private method
    private func setupRx() {
        yesButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
                self?.yesBlock?()
                WindowPopup.hideLoading()
            })
            .disposed(by: bag)
        
        noButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
                self?.noBlock?()
                WindowPopup.hideLoading()
            })
            .disposed(by: bag)
    }
    
    private func showContent() {
        if titleAlert != nil {
            titleLabel.text = titleAlert
        }
        contentLabel.text = contentAlert
        
        if noBlock == nil {
            noButton.isHidden = true
        }
    }
}
