//
//  Photo.swift
//  PetLovers
//
//  Created by David Zhou on 3/16/23.
//

import Foundation

struct Photo : Identifiable, Hashable, Equatable, Codable{
    
    let id: UUID
    let size: Size
    let urls: URLs
    let timestamp: Date
    let location: Location?
    
}

//comparable
extension Photo: Comparable {

    static func < (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
    
}

extension Photo {
    struct URLs : Hashable, Equatable, Codable{
        let full: URL
        let thumb: URL
    }
    
    struct Size : Hashable, Equatable, Codable{
        let width: Int
        let height: Int
        var aspectRadio: Double {
            return Double(width) / Double(height)
        }
    }
    
    struct Location : Hashable, Equatable, Codable{
        let lat: Double
        let lng: Double
    }
}
