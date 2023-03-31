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
    
    let data = ["3/1 Monday", "3/2 Tuesday", "3/3 Wednesday", "3/4 Thursday", "3/5 Friday", "3/6 Saturday", "3/7 Sunday", "3/8 Monday", "3/9 Tuesday", "3/10 Wednesday", "3/11 Thursday", "3/12 Friday", "3/13 Saturday", "3/14 Sunday"]
    
    let paginationEnabled : Bool
    var weekData = [String]()
    
    init(tableView: UITableView, photo: Photo, image: UIImage, paginationEnabled: Bool) {
        self.tableView = tableView
        self.photo = photo
        self.image = image
        self.paginationEnabled = paginationEnabled
        super.init()
        
        DispatchQueue.main.async {
            tableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.reuseIdentifier)
            tableView.dataSource = self
        }
    }
}

extension ListDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if paginationEnabled {
            return weekData.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellUtyped = tableView.dequeueReusableCell(withIdentifier: ListViewCell.reuseIdentifier, for: indexPath)
        guard let cell = cellUtyped as? ListViewCell else { return cellUtyped }
        cell.imageView2.image = image
        
        let title : String
        if paginationEnabled {
            title = weekData[indexPath.row]
        } else {
            title = data[indexPath.row]
        }
        
        cell.titleView.text = title
        cell.subtitleView1.text = String(photo.location!.lat)
        return cell
    }
}

extension ListDataSource {
    
    func add(weeks: [String]) {
        weekData.append(contentsOf: weeks)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
