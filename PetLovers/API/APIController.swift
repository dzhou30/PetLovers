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
