//
//  UIView+Extension.swift
//  SwiftSourceBase
//
//  Created by btanh on 8/6/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var circleRadius: Bool {
        get {
            return false
        }
        set {
            if newValue {
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    let radius = min(self.frame.width, self.frame.height) / 2.0
                    self.layer.cornerRadius = radius
                    self.layer.masksToBounds = true
                }
            }
        }
    }
    
    @IBInspectable var borderwidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.masksToBounds = true
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var bordercolor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadiusView: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            shadow()
        }
    }
    
    @IBInspectable
    var shadowOpacityView: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            shadow()
        }
    }
    
    @IBInspectable
    var shadowOffsetView: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            shadow()
        }
    }
    
    @IBInspectable
    var shadowColorView: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
            shadow()
        }
    }
    
    private func shadow() {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func roundCorner(radius: Double, roundingCorners: UIRectCorner = [.topLeft, .topRight]) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: roundingCorners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    
    func fillView(view: UIView) {
        let constraints = [
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
