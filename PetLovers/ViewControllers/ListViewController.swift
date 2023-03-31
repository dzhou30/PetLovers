//
//  ListViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/21/23.
//

import UIKit

class ListViewController: UIViewController {
    
    let dataSource : ListDataSource
    
    let image : UIImage
    let photo : Photo
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let lastPage = 10
    var currentPage = 1
    var atLastPage = false
    var paginationEnabled = true
    
    init(photo: Photo, image: UIImage) {
        self.photo = photo
        self.image = image
        dataSource = ListDataSource(tableView: self.tableView, photo: photo, image: image, paginationEnabled: paginationEnabled)
        super.init(nibName: nil, bundle: nil)
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
        
        if paginationEnabled {
            loadMore()
        }
    }
}

extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell at", indexPath.row, "is selected")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataSource.weekData.count - 1 {
            if !atLastPage {
                loadMore()
            }
        }
    }
}

extension ListViewController {
    func loadMore() {
        downloadWeeksData(weekIndex: currentPage) {result in
            print("loadMore() for week", currentPage)
            self.dataSource.add(weeks: result)
            currentPage += 1
            if currentPage == self.lastPage {
                self.atLastPage = true
            }
        }
    }
    
    func downloadWeeksData(weekIndex: Int, completion: ([String]) -> ()) {
        let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        var result = [String]()
        for i in 0..<week.count {
            let day = week[i] + " Week " + String(weekIndex)
            result.append(day)
        }
        completion(result)
    }
    
    
}
