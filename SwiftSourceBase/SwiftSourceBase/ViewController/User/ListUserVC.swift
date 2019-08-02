//
//  ListUserVC.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/28/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift

class ListUserVC: UIViewController, Storyboarded {
    // MARK: - IBOutlet
    @IBOutlet weak var contentTableView: UITableView!
    
    // MARK: - Private variable
    private var dataTable: [UserModel] = []
    private let bag = DisposeBag()
    private let refresh = UIRefreshControl()
    let viewModel = UserViewModel()
    var loadmore = LoadmoreItem()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
        setupTable()
        
        WindowPopup.showLoading()
        getDataTable()
    }
    
    // MARK: - Private method
    private func setupRx() {
        refresh.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {[weak self] (_) in
                guard let `self` = self else { return }
                
                self.loadmore.reset()
                self.getDataTable()
            })
            .disposed(by: bag)
        
        viewModel.errorString
            .subscribe(onNext: {[weak self] (error) in
                self?.hideAllLoading()
                Logger.error(error)
            })
            .disposed(by: bag)
        
        viewModel.listUser
            .subscribe(onNext: {[weak self] (users) in
                guard let `self` = self else { return }
                
                if self.loadmore.page == 0 {
                    self.dataTable = users ?? []
                } else {
                    self.dataTable.append(contentsOf: users ?? [])
                }
                
                // update loadmore condition
                self.loadmore.page += 1
                self.loadmore.hasLoadmore = self.loadmore.page > 3 ? false : true // hard code
                
                self.contentTableView.reloadData()
                self.hideAllLoading()
            })
            .disposed(by: bag)
    }
    
    private func setupTable() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.estimatedRowHeight = 10
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.tableFooterView = UIView()
        contentTableView.refreshControl = refresh
    }
    
    private func getDataTable() {
        viewModel.getListUser(page: loadmore.page, size: loadmore.size)
    }
    
    private func hideAllLoading() {
        refresh.endRefreshing()
        WindowPopup.hideLoading()
        contentTableView.hideLoadmoreView()
    }

}

extension ListUserVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.cellId, for: indexPath)
            as! UserCell
        
        let user = dataTable[indexPath.row]
        cell.fillData(user: user)
        
        return cell
    }
    
    // Load more
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.loadmoreWithAction {[weak self] in
            guard let `self` = self else { return }
            
            if self.loadmore.hasLoadmore {
                self.getDataTable()
            } else {
                scrollView.hideLoadmoreView()
            }
        }
    }
}
