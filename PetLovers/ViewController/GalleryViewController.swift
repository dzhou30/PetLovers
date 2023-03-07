//
//  GalleryViewController.swift
//  PetLovers
//
//  Created by David Zhou on 3/6/23.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var label = UILabel(frame: CGRectMake(100,100,100,100))
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        let topView = UIView(frame: .zero)
        
        let rootView = UIView(frame: UIScreen.main.bounds)
       
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.white
        label.text = "this is example text"
        view.translatesAutoresizingMaskIntoConstraints = false
        
        rootView.addSubview(label)
        view.addSubview(rootView)
        
        navigationItem.title = "Pet Lovers"
//        super.viewDidLoad()

//        var body: some View {
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//                Text("Hello, world!")
//            }
//            .padding()
//        }
//        view.addSubview(body as! UIView)
    }
}
