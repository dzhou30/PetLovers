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
    //Cache #1
    var imageCache = ImageCache(countLimit: 200)
    var imageCacheIsOn = false
    
    //Cache #2
    init() {
        let memoryCapacity = Int(Measurement(value: 300, unit: UnitInformationStorage.megabytes).converted(to: .bytes).value)
        let memoryCapacity2 = 300000000
        let diskCapacity = 1000000000
        URLSession.shared.configuration.urlCache = URLCache(memoryCapacity: memoryCapacity2, diskCapacity: diskCapacity)
        URLSession.shared.configuration.requestCachePolicy = .returnCacheDataElseLoad
    }
    
    //load photo to UIImage
    func load(photo: Photo, size: Size, completion: @escaping( (UIImage?) -> ())) {
        let url: URL
        switch size {
        case .thumb:
            url = photo.urls.thumb
        case .full:
            url = photo.urls.full
        }
        if imageCacheIsOn {
            if let image = imageCache.getImage(for: url) {
                print("loaded from cache #1")
                completion(image)
                return
            }
        }
        let task = URLSession.shared.dataTask(with: url) { data, result, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            if self.imageCacheIsOn {
                if let loadedImage = image {
                    self.imageCache.insertImage(image: loadedImage, for: url)
                }
            }
            completion(image)
        }
        tasks[photo] = task
        task.resume()
    }
    
    func cancel(photo: Photo) {
        tasks[photo]?.cancel()
        tasks[photo] = nil
    }
    
    // preLoad full size photo for displaying detail view
    // Go through all images and call loadImage to warm the cache for them
    func preLoad(photos: [Photo], completion: () -> Void) {
        for photo in photos {
            load(photo: photo, size: .full) { _ in }
        }
        completion()
    }
}

extension ImageLoader {
    
    enum Size {
        case thumb, full
    }
    
    func load3(photo: Photo, size: Size, completion: @escaping (UIImage?) -> ()) {
        let url = photo.urls.thumb
        let task = URLSession.shared.dataTask(with: url) {data, _ , _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
}

class ImageCache {
    
    var cache = NSCache<AnyObject, AnyObject>()
    let lock = NSLock()
    var countLimit: Int
    
    init(countLimit: Int) {
        self.countLimit = countLimit
        cache.countLimit = countLimit
    }
    
    func insertImage(image: UIImage, for url: URL) {
        //lock.lock()
        cache.setObject(image, forKey: url as AnyObject)
        //lock.unlock()
    }
    
    func removeImage(image: UIImage, for url: URL) {
        //lock.lock()
        cache.removeObject(forKey: url as AnyObject)
        //lock.unlock()
    }
    
    func getImage(for url: URL) -> UIImage? {
        //lock.lock()
        if let image = cache.object(forKey: url as AnyObject) as? UIImage {
            return image
        }
        return nil
        //lock.unlock()
    }
}
