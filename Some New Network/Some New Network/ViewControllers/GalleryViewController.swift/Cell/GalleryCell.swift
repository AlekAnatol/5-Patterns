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

    func configure(photo: UIImage?, likeCount: Int) {
        fotoImageView.image = photo
        self.likeCount = likeCount
        heartCounterView.configure(count: likeCount)
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


