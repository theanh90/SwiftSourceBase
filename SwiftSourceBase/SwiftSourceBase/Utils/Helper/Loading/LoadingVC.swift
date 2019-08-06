//
//  LoadingVC.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/28/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - Private variable
    private lazy var activity: NVActivityIndicatorView = {
        let active = NVActivityIndicatorView(frame: .zero,
                                       type: .ballClipRotate,
                                       color: UIColor.hexString("#E94E5D"),
                                       padding: 15)
        
        active.backgroundColor = .white
        active.layer.cornerRadius = 18
        active.layer.masksToBounds = true
        
        return active
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLoading()
    }

    // MARK: - Private method
    private func setupLoading() {
        activity.frame = loadingView.bounds
        activity.startAnimating()
        loadingView.addSubview(activity)
        loadingView.backgroundColor = .clear
    }

}
