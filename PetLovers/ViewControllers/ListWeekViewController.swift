//
//  ListWeekViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation
import UIKit

class ListWeekViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let lastPage = 10
    var currentPage = 1
    var atLastPage = false
    var paginationEnabled = true
    var rewriteFetchingLoggicEnabled = true
    
    //QQ: should put isLoading in VC or Controller, which thread should it be?
    var isLoading = false
    
    let controller = ListWeekController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        DispatchQueue.main.async {
            self.tableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.reuseIdentifier)
            self.tableView.dataSource = self.controller.dataSource
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        loadMore()
    }
}

extension ListWeekViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell at", indexPath.row, "is selected")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == controller.dataSource.weekData.count - 1 {
            if !atLastPage {
                loadMore()
            }
        }
    }
}

extension ListWeekViewController {
    func loadMore() {
        guard !isLoading else { return }
        isLoading = true
        controller.loadMore() {
            //TODO: should switch back to VC thread?
            loadMoreComplete()
        }
    }
    
    func loadMoreComplete() {
        print("[ListWeekViewController] loadMoreComplete() for week", currentPage)
        currentPage += 1
        if currentPage == self.lastPage {
            atLastPage = true
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        isLoading = false
    }
}
