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
    
    init(photo: Photo, image: UIImage) {
        self.photo = photo
        self.image = image
        dataSource = ListDataSource(tableView: self.tableView, photo: photo, image: image)
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
    }
}

extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell at", indexPath.row, "is selected")
    }
}
