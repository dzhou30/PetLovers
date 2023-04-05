//
//  ListWeekDataSource.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation
import UIKit

class ListWeekDataSource : NSObject {
    
    static let threadIdentifier = "com.listWeekDataSource"
    
    let imageLoader : ImageLoader
    
    var weekData = [Week]()
    let thread : DispatchQueue

    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
        //this thread updates data model in serial queue
        thread = DispatchQueue(label: ListWeekDataSource.threadIdentifier, qos: .userInitiated)
    }
}

extension ListWeekDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellUtyped = tableView.dequeueReusableCell(withIdentifier: ListViewCell.reuseIdentifier, for: indexPath)
        guard let cell = cellUtyped as? ListViewCell else { return cellUtyped }
        
        let week = weekData[indexPath.row]
        //TODO: should data source load image or put UIImage in viewModel
        //data source can load image as this is process of binding data(UIImage)
        imageLoader.load(url: week.url) { image in
            DispatchQueue.main.async {
                cell.imageView2.image = image
            }
        }
        cell.titleView.text = week.title
        cell.subtitleView1.text = week.subtitle
        return cell
    }
}

extension ListWeekDataSource {
    
    func add(weeks: [Week]) {
        // guard data model change in serial queue
        thread.async { [weak self] in
            self?.weekData.append(contentsOf: weeks)
        }
    }
}

