//
//  GalleryDataSource.swift
//  PetLovers
//
//  Created by David Zhou on 3/20/23.
//

import Foundation
import UIKit

class GalleryDataSource: NSObject {
    
    private var photos: [Photo] = []
    private var imageLoader: ImageLoader
    private var collectionView: UICollectionView
    
    init(collectionView: UICollectionView, imageLoader: ImageLoader) {
        self.collectionView = collectionView
        self.imageLoader = imageLoader
        super.init()
        DispatchQueue.main.async {
            collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseIdentifier)
            collectionView.dataSource = self
        }
    }
}

extension GalleryDataSource : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellUtyped = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.reuseIdentifier, for: indexPath)
        guard let cell = cellUtyped as? GalleryCell else { return cellUtyped }
        guard let photo = photo(at: indexPath) else { return cell }
        imageLoader.load(photo: photo, size: .thumb) { image in
            //print("photo's image at", indexPath , "is loaded to collectionView cell")
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension GalleryDataSource {
    
    func sizeForItem(at indexPath: IndexPath) -> CGSize {
        guard let photo = photo(at: indexPath) else {
            return .zero
        }
        return CGSize(width: photo.size.width, height: photo.size.height)
    }
}

extension GalleryDataSource {
    
    func add(photos: [Photo]) {
        self.photos.append(contentsOf: photos)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func photo(at indexPath: IndexPath) -> Photo? {
        return photos[indexPath.item]
    }
}


