//
//  ListWeekDataSource.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation
import UIKit

class ListWeekDataSource : NSObject {
    
    let imageLoader : ImageLoader
    
    var weekData = [Week]()
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
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
        weekData.append(contentsOf: weeks)
    }
}

