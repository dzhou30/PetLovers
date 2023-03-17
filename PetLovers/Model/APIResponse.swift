//
//  APIResponse.swift
//  PetLovers
//
//  Created by David Zhou on 3/16/23.
//

import Foundation

struct APIResponse: Codable {
    let photo: [Photo]
    let cursor: UUID?
    
}
