//
//  ListWeekDataSource.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation
import UIKit

// data source is belongs to View layer
class ListWeekDataSource : NSObject {
    
    let imageLoader : ImageLoader
    let controller : ListWeekController

    init(controller: ListWeekController, imageLoader: ImageLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
}

extension ListWeekDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.getListWeekData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellUtyped = tableView.dequeueReusableCell(withIdentifier: ListViewCell.reuseIdentifier, for: indexPath)
        guard let cell = cellUtyped as? ListViewCell else { return cellUtyped }
        
        //sync API
        //let week = controller.getListWeekData()[indexPath.row]
        
        //async API
        controller.getListWeekDataAsync() { [weak self] (weekData) in
            let week = weekData[indexPath.row]
            //TODO: should data source load image or put UIImage in viewModel
            //data source can load image as this is process of binding data(UIImage)
            self?.imageLoader.load(url: week.url) { image in
                DispatchQueue.main.async {
                    cell.imageView2.image = image
                }
            }
            DispatchQueue.main.async {
                cell.titleView.text = week.title
                cell.subtitleView1.text = week.subtitle
            }
        }
        return cell
    }
}
