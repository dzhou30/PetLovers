//
//  GalleryCell.swift
//  PetLovers
//
//  Created by David Zhou on 3/20/23.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

extension GalleryCell {
    
    func configure() {
        imageView.contentMode = .scaleAspectFit
        //try use scaleAspectFill
        //imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
}

extension GalleryCell {
    
    static var reuseIdentifier = "GalleryCell"
    
}
