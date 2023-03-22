//
//  ListDataSource.swift
//  PetLovers
//
//  Created by David Zhou on 3/21/23.
//

import Foundation
import UIKit

class ListDataSource : NSObject {
    
    let tableView : UITableView
    let image : UIImage
    let photo : Photo
    
    let data = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday2", "Tuesday2", "Wednesday2", "Thursday2", "Friday2", "Saturday2", "Sunday2"]
    
    init(tableView: UITableView, photo: Photo, image: UIImage) {
        self.tableView = tableView
        self.photo = photo
        self.image = image
        super.init()
        
        DispatchQueue.main.async {
            tableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.reuseIdentifier)
            tableView.dataSource = self
        }
    }
}

extension ListDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellUtyped = tableView.dequeueReusableCell(withIdentifier: ListViewCell.reuseIdentifier, for: indexPath)
        guard let cell = cellUtyped as? ListViewCell else { return cellUtyped }
        cell.imageView2.image = image
        cell.titleView.text = data[indexPath.row]
        cell.subtitleView1.text = String(photo.location!.lat)
        return cell
    }
    
}
