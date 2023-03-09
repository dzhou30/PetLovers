//
//  GalleryViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/7/23.
//

import UIKit

class GalleryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 1000, height: 100))
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        label.text = "this is doudou photo"
        
        
        self.view.addSubview(label)
        navigationItem.title = "Doudou"
    }
}
