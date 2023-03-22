//
//  ListViewCell.swift
//  PetLovers
//
//  Created by David Zhou on 3/21/23.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    var imageView2 = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
    let titleView = UILabel()
    let subtitleView1 = UILabel()
    
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        contentView.addSubview(imageView2)
        containerView.addSubview(titleView)
        containerView.addSubview(subtitleView1)
        contentView.addSubview(containerView)
        
        imageView2.contentMode = .scaleAspectFit
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView2.widthAnchor.constraint(equalToConstant: 70),
            imageView2.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        subtitleView1.translatesAutoresizingMaskIntoConstraints = false
        subtitleView1.textColor = UIColor.red
        subtitleView1.backgroundColor = UIColor.black
        NSLayoutConstraint.activate([
            subtitleView1.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            subtitleView1.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
}

extension ListViewCell {
    
    static var reuseIdentifier = "ListViewCell"
}
