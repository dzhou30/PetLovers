//
//  ListWeekController.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation

class ListWeekController {
    
    static let threadIdentifier = "com.listWeekController"
    
    // dependencies inject
    let weekDataServices = WeekDataService()
    let imageLoader = ImageLoader()
    
    //ivar
    let lastPage = 10
    var currentPage = 1
    var atLastPage = false
    var weekIndex = 0
    
    var isLoading = false

    //init
    let dataSource : ListWeekDataSource
    let thread : DispatchQueue
    
    init() {
        dataSource = ListWeekDataSource(imageLoader: imageLoader)
        //this thread updates ivar of currentPage and isLoading state
        thread = DispatchQueue(label: ListWeekController.threadIdentifier, qos: .userInteractive)
    }
    
    func fetchWeekData(completion: @escaping () -> Void) {
        thread.async { [weak self] in
            self?.fetchWeekDataAndUpdateDataSource(completion: completion)
        }
    }
    
    private func fetchWeekDataAndUpdateDataSource(completion: @escaping () -> Void) {
        guard !isLoading  else { return }
        guard !atLastPage else { return }
        isLoading = true
        
        weekDataServices.fetchWeekData2(weekIndex: weekIndex) { [weak self] (weekData) in
            self?.thread.async {
                self?.fetchCompleteAndUpdateDataSource(weekData: weekData, completion: completion)
            }
        }
    }
    
    func fetchCompleteAndUpdateDataSource(weekData: [Week], completion: @escaping () -> Void) {
        print("[ListWeekController] fetchCompleteAndUpdateDataSource() for week", currentPage)
        isLoading = false
        currentPage += 1
        if currentPage == lastPage {
            atLastPage = true
        }
        dataSource.add(weeks: weekData)
        completion()
    }
}
