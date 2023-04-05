//
//  WeekDataServices.swift
//  PetLovers
//
//  Created by David Zhou on 3/31/23.
//

import Foundation

class WeekDataService {
    
    let week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let urlString = "https://storage.googleapis.com/kitunia/thumbs/1ca43621-36b6-4b70-bc89-5267bed79c2c.jpg"
    let url : URL
    let subtitle = "subtitle"
    var weekDataIndex = 1
    
    init() {
        url = URL(string: urlString)!
    }
    
    //TODO: protocol can return callback / observable
    func fetchWeekData(weekIndex: Int) -> [Week] {
        //TODO: can switch to a lower thread
        return generateWeekData()
    }
    
    private func generateWeekData() -> [Week] {
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
