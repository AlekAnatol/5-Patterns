//
//  GalleryCell.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 14.01.2022.
//

import UIKit

protocol GalleryCellProtocol: AnyObject {
    func countIncrement(count: Int)
    func countDecrement(count: Int)
    func sourceCount() -> Int

}

class GalleryCell: UICollectionViewCell {

    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var heartCounterView: LikesCounterControlView!
    
    var likeCount = 0
    weak var delegate: GalleryCellProtocol?
    
    override func prepareForReuse() {
        fotoImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heartCounterView.delegate = self
    }

    func configure(fotoPath: String, likeCount: Int) {
        fotoImageView.image = loadImage(urlString: fotoPath)
        self.likeCount = likeCount
        heartCounterView.configure(count: likeCount)
    }
    
    func loadImage(urlString: String) -> UIImage? {
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!) {
            return UIImage(data: data)
        } else {
            return UIImage(named: "1")
        }
    }
}


extension GalleryCell: LikesCounterControlViewProtocol {
    func countIncrement(count: Int) {
        delegate?.countIncrement(count: count)
        print(count)
    }

    func countDecrement(count: Int) {
        delegate?.countDecrement(count: count)
        print(count)
    }
}


