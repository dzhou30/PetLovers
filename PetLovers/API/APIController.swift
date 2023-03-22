//
//  APIController.swift
//  PetLovers
//
//  Created by David Zhou on 3/8/23.
//

import Foundation

class APIController {
    //TODO: rewrite
    fileprivate let baseURL: String

    init(baseURL: String = Constants.defaultBaseURL) {
        self.baseURL = baseURL
    }

    func retrievePhotos(from cursor: UUID? = nil, completion: @escaping (Result<APIResponse, Swift.Error>) -> ()) {
        var components = URLComponents(string: Constants.defaultBaseURL)
        components?.path = Constants.photosEndpoint
        if let cursor = cursor {
            components?.queryItems = [URLQueryItem(name: Constants.cursorParameter, value: cursor.uuidString)]
        }
        guard let url = components?.url else {
            completion(.failure(Error.invalidURL))
            return
        }
        print(components?.url?.absoluteString)
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let data = data else {
                    completion(.failure(Error.invalidResponse))
                    return
                }

                let decoded = try! decoder.decode(APIResponse.self, from: data)
                completion(.success(decoded))
            }
        }
        task.resume()
    }
    //TODO: rewrite

}

extension APIController {
    //TODO: rewrite
    struct Constants {
        static let defaultBaseURL = "https://us-central1-kitunia.cloudfunctions.net"
        static let photosEndpoint = "/photos"
        static let cursorParameter = "cursor"
    }

    enum Error: Swift.Error {
        case invalidURL
        case invalidResponse
    }
}

// Below is testing API controller implementation
extension APIController {   //testing, rewrite
    
    func retrievePhotos2(from cursor: UUID?, completion: @escaping (Result<APIResponse, Swift.Error>) -> ()) {
        var components = URLComponents(string: Constants.defaultBaseURL)
        components?.path = Constants.photosEndpoint
        if let cursor = cursor {
            components?.queryItems = [URLQueryItem(name: Constants.cursorParameter, value: cursor.uuidString)]
        }
        guard let url = components?.url else {
            completion(.failure(Error.invalidURL))
            return
        }
        print(components?.url?.absoluteString)
        
        //"https://us-central1-kitunia.cloudfunctions.net/photos?cursor=1CF86221-xxx"
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(error))
            } else {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let data = data else {
                    completion(.failure(Error.invalidResponse))
                    return
                }
                let decoded = try! decoder.decode(APIResponse.self, from: data)
                completion(.success(decoded))
            }
        }
        task.resume()
    }
    
    //JSON data example
    /*
     {"cursor":"14c5d8b1-23cb-4012-ad07-1957a757c038",
      "photos":[{
            "id":"1ca43621-36b6-4b70-bc89-5267bed79c2c",
            "location":{"lat":33.98667957657661,"lng":-118.44086671809845},
            "size":{"height":4032,"width":3024},
            "timestamp":"2019-08-11T17:28:00Z",
            "urls":{"full":"https://storage.googleapis.com/kitunia/full/1ca43621-36b6-4b70-bc89-5267bed79c2c.jpg","thumb":"https://storage.googleapis.com/kitunia/thumbs/1ca43621-36b6-4b70-bc89-5267bed79c2c.jpg"}
        },
        {
            "id":"f208adfb-c2ae-4d63-8962-51fb62df94b5",
            "location":{"lat":33.98635682582954,"lng":-118.4414206157725},
            "size":{"height":4032,"width":3024},
            "timestamp":"2019-08-11T17:28:03Z",
            "urls":{"full":"https://storage.googleapis.com/kitunia/full/f208adfb-c2ae-4d63-8962-51fb62df94b5.jpg","thumb":"https://storage.googleapis.com/kitunia/thumbs/f208adfb-c2ae-4d63-8962-51fb62df94b5.jpg"}
        }]
     }
     */
}

struct Photo2: Codable, Equatable, Hashable {
    let id: UUID                //xx String
    let location: Location?     //xx Location
    let size: Size
    let timestamp: Date         //xx NSDate
    let urls: URLS
    
    struct Location: Codable, Hashable, Equatable {
        let lat: Int
        let lng: Int
    }
    
    struct Size: Codable, Hashable, Equatable {
        let height: Int
        let width: Int
    }
    
    struct URLS: Codable, Hashable, Equatable {
        let full: URL
        let thumb: URL
    }
    
    static func < (lhs: Photo2, rhs: Photo2) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
}
