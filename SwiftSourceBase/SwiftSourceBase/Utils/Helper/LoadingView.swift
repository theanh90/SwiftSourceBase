//
//  LoadingView.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/26/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

import UIKit
import NVActivityIndicatorView

class LoadingView: UIView {
    public static let instance = LoadingView()
    
    var bgLoadingView: UIView
    var active: NVActivityIndicatorView
    
    init() {
        bgLoadingView = UIView(frame: .zero)
        active = NVActivityIndicatorView(frame: .zero, type: .ballScaleRippleMultiple, color: UIColor.hexString("404040"), padding: 13)
        
        super.init(frame: .zero)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        bgLoadingView = UIView(frame: .zero)
        active = NVActivityIndicatorView(frame: .zero, type: .ballScaleRippleMultiple, color: UIColor.hexString("404040"), padding: 13)
        
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    private func commonSetup() {
        // setup
        bgLoadingView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        let activeFr = CGRect(x: 0, y: 0, width: 90, height: 90)
        active.frame = activeFr
        active.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        
        active.backgroundColor = .white
        active.layer.cornerRadius = 15
        active.layer.masksToBounds = true
        bgLoadingView.addSubview(active)
        bgLoadingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func showProgress() -> UIView {
        active.startAnimating()
        return bgLoadingView
    }
    
    public func hideProgress() {
        if active.isAnimating {
            active.stopAnimating()
            bgLoadingView.removeFromSuperview()
        }
    }
    
    public func setProgressFrame(frame: CGRect) {
        bgLoadingView.frame = frame
        active.center = bgLoadingView.center
    }
    
}
