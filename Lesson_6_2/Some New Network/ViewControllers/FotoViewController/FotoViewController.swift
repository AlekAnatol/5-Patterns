//
//  FotoViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 15.01.2022.
//

import UIKit

class FotoViewController: UIViewController {
    
    private var photo: UIImage?
    
    func configure(photo: UIImage?) {
        self.photo = photo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.brandPink
        let imageView = UIImageView(frame: CGRect(x: 20,
                                                  y: self.view.bounds.height/2 - self.view.bounds.height/4,
                                                  width: self.view.bounds.width - 40,
                                                  height: self.view.bounds.height/2))
        
//        guard let photoURL = URL(string: photo) else { return }
//        if let data = try? Data(contentsOf: photoURL) {
//            if let image = UIImage(data: data) {
                imageView.image = photo
//            }
//        }
        
        self.view.addSubview(imageView)
    }
}
