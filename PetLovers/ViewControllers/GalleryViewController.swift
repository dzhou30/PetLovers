//
//  GalleryViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/7/23.
//

import UIKit

class GalleryViewController: UIViewController {
    let api = APIController()
    var cursor : UUID?
    
    var testImage: UIImage?
    let imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 1000, height: 100))
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        label.text = "this is doudou photo"
        
        self.view.addSubview(label)
        navigationItem.title = "Pet Lovers"
        
        loadMorePhotos()
    }
}

extension GalleryViewController {
    func loadMorePhotos() {
        
        //TODO: rewrite
        api.retrievePhotos(from: cursor) { result in
            switch result {
            case .failure(let error):
                print(error)
                // TODO: HANDLE
            case .success(let response):
                self.cursor = response.cursor
//                self.imageLoader.preload(photos: response.photos, queue: .global(qos: .default)) {
//                    print("All photos preloaded")
//                }
//                DispatchQueue.main.async {
//                    self.dataSource.add(photos: response.photos)
//                }
                self.loadFirstImage(photo: response.photos[0], count: response.photos.count)
            }
        }
        //TODO: rewrite
    }
    
    func loadFirstImage(photo: Photo, count: Int) {
        imageLoader.load(photo: photo, size: .thumb) { image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self.displayFirstImage(image: image, count: count)
            }
        }
    }
    
    func displayFirstImage(image: UIImage, count: Int) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        view.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 100, y: 400, width: 1000, height: 100))
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        label.text = "There are \(count) photos are loaded"
        
        self.view.addSubview(label)
    }
}
