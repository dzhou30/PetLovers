//
//  ListWeekController.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation

class ListWeekController {
    
    // dependencies inject
    let weekDataServices = WeekDataService()
    let imageLoader = ImageLoader()
    let dataSource : ListWeekDataSource
    
    //var isLoading = false
    var weekIndex = 0
    
    init() {
        dataSource = ListWeekDataSource(imageLoader: imageLoader)
    }
    
    func loadMore(completion: () -> Void) {
        let weekData = weekDataServices.fetchWeekData(weekIndex: weekIndex)
        
        dataSource.add(weeks: weekData)
        completion()
    }
    
}
