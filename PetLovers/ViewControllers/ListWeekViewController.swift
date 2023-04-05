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
    
    //QQ: should put isLoading in VC or Controller, which thread should it be?
    //isLoading should be put in controller for managing state
    
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
            loadMore()
        }
    }
}

extension ListWeekViewController {

    func loadMore() {
        controller.fetchWeekData() { [weak self] in
            //TODO: should switch back to VC thread?
            //Yes
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
