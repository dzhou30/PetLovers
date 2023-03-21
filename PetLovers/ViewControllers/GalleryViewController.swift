//
//  GalleryViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/7/23.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class GalleryViewController: UIViewController {
    let api = APIController()
    var cursor : UUID?
    
    var testImage: UIImage?
    let imageLoader = ImageLoader()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CHTCollectionViewWaterfallLayout())
    var loading = false
    lazy var dataSource: GalleryDataSource = {
        GalleryDataSource(collectionView: self.collectionView, imageLoader: self.imageLoader)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test add label view to main page
        //        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 1000, height: 100))
        //        label.textColor = UIColor.red
        //        label.backgroundColor = UIColor.white
        //        label.text = "this is doudou photo"
        //        self.view.addSubview(label)
        
        navigationItem.title = "Pet Lovers"
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        //add long press gesture / double tap
        loadMorePhotos()
    }
}

extension GalleryViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = dataSource.photo(at: indexPath) else {
            return
        }
        print("photo at", indexPath, "is clicked")
    }
}

extension GalleryViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.sizeForItem(at: indexPath)
        //return CGSize(width: view.frame.size.width/3, height: view.frame.size.width/3)
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        return 2
    }
}

extension GalleryViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.kit_isAtBottom else { return }
        loadMorePhotos()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard scrollView.kit_isAtBottom else { return }
        loadMorePhotos()
    }
}

extension UIScrollView {
    
    var kit_isAtBottom: Bool {
        return contentOffset.y + frame.size.height >= contentSize.height
    }
}

extension GalleryViewController {
    func loadMorePhotos() {
        guard !loading else { return }
        loading = true
        
        //TODO: rewrite
        api.retrievePhotos(from: cursor) { result in
            switch result {
            case .failure(let error):
                print(error)
                // TODO: HANDLE
            case .success(let response):
                self.cursor = response.cursor
//                DispatchQueue.main.async {
//                    self.dataSource.add(photos: response.photos)
//                }
                //self.loadFirstImage(photo: response.photos[0], count: response.photos.count)
                self.dataSource.add(photos: response.photos)
                print("load more photos and add to data source")
                
                self.imageLoader.preLoad(photos: response.photos) {
                    print("all photos are preloaded")
                }
            }
            self.loading = false
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
