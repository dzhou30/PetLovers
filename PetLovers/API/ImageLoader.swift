//
//  ImageLoader.swift
//  PetLovers
//
//  Created by David Zhou on 3/16/23.
//

import Foundation
import UIKit

class ImageLoader {
    
    var tasks : [Photo: URLSessionDataTask] = [:]
    
    //load photo to UIImage
    func load(photo: Photo, size: Size, completion: @escaping( (UIImage?) -> ())) {
        let url: URL
        switch size {
        case .thumb:
            url = photo.urls.thumb
        case .full:
            url = photo.urls.full
        }
        let task = URLSession.shared.dataTask(with: url) { data, result, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        tasks[photo] = task
        task.resume()
    }
}

extension ImageLoader {
    enum Size {
        case thumb, full
    }
}
