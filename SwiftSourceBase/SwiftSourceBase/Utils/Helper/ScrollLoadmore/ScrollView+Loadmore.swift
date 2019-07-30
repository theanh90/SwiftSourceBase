//
//  ScrollView+Loadmore.swift
//  Core
//
//  Created by AnhBui on 10/15/18.
//  Copyright © 2018 Anh The. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Declare variable
extension UIScrollView {
    fileprivate var loadmoreSize: CGFloat {
        get {
            return 100
        }
    }
    
    fileprivate var distanceTrigger: CGFloat {
        get {
            return 100
        }
    }
    
    fileprivate struct LoadmoreProperties {
        static var isAddRefresh: Bool = false
        static var refreshView: UIView?

        static var loadmoreView: UIView?
        static var isAddLoadmore: Bool = false
    }
    
    // for collectionview horizontal
    fileprivate var loadmoreSizeHorizontal: CGFloat {
        get {
            return 70
        }
    }
    
    fileprivate var distanceTriggerHorizontal: CGFloat {
        get {
            return 75
        }
    }
    
    // Refresh
    fileprivate var isAddRefresh: Bool {
        get {
            return LoadmoreProperties.isAddRefresh
        }
        set {
            LoadmoreProperties.isAddRefresh = newValue
        }
    }
    
    fileprivate var refreshView: UIView? {
        get {
            if let refreshView = LoadmoreProperties.refreshView {
                return refreshView
            }
            return nil
        }
        set {
            LoadmoreProperties.refreshView = newValue
        }
    }
    
    // Loadmore
    fileprivate var loadmoreView: UIView? {
        get {
            if let loadmoreView = LoadmoreProperties.loadmoreView {
                return loadmoreView
            }
            return nil
        }
        set {
            LoadmoreProperties.loadmoreView = newValue
        }
    }
    
    fileprivate var isAddLoadmore: Bool {
        get {
            return LoadmoreProperties.isAddLoadmore
        }
        set {
            LoadmoreProperties.isAddLoadmore = newValue
        }
    }
}

// MARK: - Handle loadmore
extension UIScrollView {
    // MARK: - Public method
    func refreshWithAction(isHorizontal: Bool = false, action: () -> Void) {
        if self is UICollectionView {
            refreshUICollectionViewWithAction(isHorizontal: isHorizontal, action: action)
        }
    }
    
    func loadmoreWithAction(isHorizontal: Bool = false, action: () -> Void) {
        if self is UITableView {
            loadmoreTableViewWithAction(action: action)
        } else if self is UICollectionView {
            loadmoreUICollectionViewWithAction(isHorizontal: isHorizontal, action: action)
        }
    }
    
    func hideRefreshView(isHorizontal: Bool = false) {
        if self.isAddRefresh {
            self.refreshView?.removeFromSuperview()
            self.isAddRefresh = false
            var contentInset = self.contentInset
            
            // rollback content inset
            if isHorizontal { // for collectionview horizontal direction
                contentInset.left -= loadmoreSizeHorizontal
            }
            
            self.contentInset = contentInset
        }
    }
    
    func hideLoadmoreView(isHorizontal: Bool = false) {
        if self.isAddLoadmore {
            self.loadmoreView?.removeFromSuperview()
            self.isAddLoadmore = false
            var contentInset = self.contentInset
            
            // rollback content inset
            if isHorizontal { // for collectionview horizontal direction
                contentInset.right -= loadmoreSizeHorizontal
            } else {
                contentInset.bottom -= loadmoreSize
            }
            
            self.contentInset = contentInset
        }
    }
    
    // MARK: - Table View
    fileprivate func refreshUICollectionViewWithAction(isHorizontal: Bool, action: () -> Void) {
        if isHorizontal {
            // check if there don't need show refresh
            if self.contentOffset.x > -distanceTriggerHorizontal {
                return
            }
            
            // only one refresh view is added
            if self.isAddRefresh {
                return
            }
            self.isAddRefresh = true
            
            // loadmore view
            var loadmoreFr = CGRect.zero
            loadmoreFr.size = CGSize(width: loadmoreSizeHorizontal, height: loadmoreSizeHorizontal)
            loadmoreFr.origin.x = -loadmoreSizeHorizontal
            let loadmoreView = UIActivityIndicatorView(frame: loadmoreFr)
            loadmoreView.center.y = self.frame.size.height/2
            loadmoreView.style = .gray
            loadmoreView.startAnimating()
            loadmoreView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            
            // change content inset to show loadmoreView
            var contentInset = self.contentInset
            contentInset.left += loadmoreSizeHorizontal
            self.contentInset = contentInset
            self.addSubview(loadmoreView)
            self.refreshView = loadmoreView
            
            // do action closure
            action()
        }
    }
    
    fileprivate func loadmoreTableViewWithAction(action: () -> Void) {
        // check if there don't need show loadmore
        guard let `self` = self as? UITableView else { return }
        
        if self.contentSize.height < self.frame.size.height
            || (self.contentOffset.y + self.frame.size.height < self.contentSize.height + distanceTrigger) {
            return
        }
        
        // only one loadmoreview is added
        if self.isAddLoadmore {
            return
        }
        self.isAddLoadmore = true
        
        let footerView = self.tableFooterView
        if footerView == nil {
            self.tableFooterView = UIView()
        }
        
        // loadmore view
        let tableSize = self.frame.size
        let loadmoreView = UIActivityIndicatorView(frame: CGRect(x: 0, y: (self.tableFooterView?.frame.size.height)!, width: tableSize.width, height: loadmoreSize))
        loadmoreView.style = .gray
        loadmoreView.startAnimating()
        loadmoreView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // change content inset to show loadmoreView
        var contentInset = self.contentInset
        contentInset.bottom += loadmoreSize
        self.contentInset = contentInset
        self.tableFooterView?.addSubview(loadmoreView)
        self.loadmoreView = loadmoreView
        
        // do action closure
        action()
    }
    
    // MARK: - Collection View
    fileprivate func loadmoreUICollectionViewWithAction(isHorizontal: Bool, action: () -> Void) {
        guard let _ = self as? UICollectionView else { return }
        
        if isHorizontal {
            loadmoreCollectionViewScrollHorizontal(action: action)
        } else {
            loadmoreCollectionViewScrollVertical(action: action)
        }
    }
    
    fileprivate func loadmoreCollectionViewScrollHorizontal(action: () -> Void) {
        // check if there don't need to show loadmore
        if self.contentSize.width < self.frame.size.width
            || (self.contentOffset.x + self.frame.size.width < self.contentSize.width + distanceTriggerHorizontal) {
            return
        }
        
        // only one loadmoreview is added
        if self.isAddLoadmore {
            return
        }
        self.isAddLoadmore = true
        
        // loadmore view
        var loadmoreFr = CGRect.zero
        loadmoreFr.size = CGSize(width: loadmoreSizeHorizontal, height: loadmoreSizeHorizontal)
        loadmoreFr.origin.x = self.contentSize.width
        let loadmoreView = UIActivityIndicatorView(frame: loadmoreFr)
        loadmoreView.center.y = self.frame.size.height/2
        loadmoreView.style = .gray
        loadmoreView.startAnimating()
        loadmoreView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        // change content inset to show loadmoreView
        var contentInset = self.contentInset
        contentInset.right += loadmoreSizeHorizontal
        self.contentInset = contentInset
        self.addSubview(loadmoreView)
        self.loadmoreView = loadmoreView
        
        // do action closure
        action()
    }
    
    fileprivate func loadmoreCollectionViewScrollVertical(action: () -> Void) {
        // check if there don't need to show loadmore
        if self.contentSize.height < self.frame.size.height
            || (self.contentOffset.y + self.frame.size.height < self.contentSize.height + distanceTrigger) {
            return
        }
        
        // only one loadmoreview is added
        if self.isAddLoadmore {
            return
        }
        self.isAddLoadmore = true
        
        // loadmore view
        var loadmoreFr = CGRect.zero
        loadmoreFr.size = CGSize(width: loadmoreSize, height: loadmoreSize)
        loadmoreFr.origin.y = self.contentSize.height
        let loadmoreView = UIActivityIndicatorView(frame: loadmoreFr)
        loadmoreView.center.x = self.center.x
        loadmoreView.style = .gray
        loadmoreView.startAnimating()
        loadmoreView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // change content inset to show loadmoreView
        var contentInset = self.contentInset
        contentInset.bottom += loadmoreSize
        self.contentInset = contentInset
        self.addSubview(loadmoreView)
        self.loadmoreView = loadmoreView
        
        // do action closure
        action()
    }
    
}
