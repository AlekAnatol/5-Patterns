//
//  GalleryViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 14.01.2022.
//

import UIKit
import RealmSwift

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    var fotoArray = [Photo]()
    //var fotoArray = [PhotoLikes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brandPink
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierGalleryCell, for: indexPath) as? GalleryCell else {return UICollectionViewCell()}
        
        cell.delegate = self
        cell.configure(fotoPath: fotoArray[indexPath.item].url, likeCount: fotoArray[indexPath.item].likesCount)
        return cell
    }
}

extension GalleryViewController: GalleryCellProtocol {
    func countIncrement(count: Int) {
        print(count)
    }
    
    func countDecrement(count: Int) {
        print(count)
    }
    
    func sourceCount() -> Int {
        return 100
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let heightBottoControl: CGFloat = 50
        
        let width = collectionView.bounds.width/3 - 30
        return CGSize(width: width, height: width + heightBottoControl)
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let fotoViewController = FotoViewController()
        fotoViewController.configure(photoURL: fotoArray[indexPath.item].url)
        self.navigationController?.pushViewController(fotoViewController, animated: true)
    }
    
}


