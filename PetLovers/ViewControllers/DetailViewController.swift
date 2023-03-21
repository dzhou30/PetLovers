//
//  DetailViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/21/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo : Photo
    var imageLoader : ImageLoader
    
    let imageView = UIImageView()
    
    init(photo: Photo, imageLoader: ImageLoader) {
        self.photo = photo
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        imageLoader.load(photo: photo, size: .full) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: CGFloat(photo.size.aspectRadio))
        ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        //double tap
        //tapGestureRecognizer.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("image is tapped")
    }
}
