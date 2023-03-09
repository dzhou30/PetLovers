//
//  APIController.swift
//  PetLovers
//
//  Created by David Zhou on 3/8/23.
//

import Foundation

class APIController {
    func retrievePhotos(from cursor: UUID? = nil,
                        completion: @escaping (Result<APIResponse, Swift.Error>) -> ()) {
        var componnets = URLComponents(string: Constants.defaultBaseURL)
        
        //cursor
    }
}

extension APIController {
    struct Constants {
        static let defaultBaseURL = "https://us-central1-kitunia.cloudfunctions.net"
    }
}
