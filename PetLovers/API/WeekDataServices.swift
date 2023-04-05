//
//  WeekDataServices.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation

class WeekDataService {
    
    static let threadIdentifier = "com.weekDataService"
    
    let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let urlString = "https://storage.googleapis.com/kitunia/thumbs/1ca43621-36b6-4b70-bc89-5267bed79c2c.jpg"
    let subtitle = "subtitle"
    var weekDataIndex = 1

    let url : URL
    let thread : DispatchQueue
    
    init() {
        url = URL(string: urlString)!
        //this thread fetch week data in background thread
        thread = DispatchQueue(label: WeekDataService.threadIdentifier, qos: .userInitiated)
    }
    
    func fetchWeekData(weekIndex: Int, completion: @escaping (([Week]) -> ())) {
        thread.async { [weak self] in
            let weekData = self?.generateWeekData()
            completion(weekData!)
        }
    }
    
    func generateWeekData() -> [Week] {
        var result = [Week]()
        for i in 0..<week.count {
            let title = week[i] + " Week " + String(weekDataIndex)
            let week = Week(url: url, title: title, subtitle: subtitle)
            result.append(week)
        }
        weekDataIndex += 1
        return result
    }
}
