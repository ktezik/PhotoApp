//
//  FavoritPhotosTableViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import UIKit

class FavoritePhotosCollectionViewController: UICollectionViewController {

    var photos = Base.shared.infos

    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Base.shared.infos.count)
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let photo = Base.shared.infos
        photos = photo
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        let photo = photos[indexPath.item].info
        cell.photo = photo
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        guard let image = cell.photoImageView.image else { return }
        
        let detailVC = SecondSelectedViewController()
        
        detailVC.indexPath = indexPath.item
        detailVC.image = image
        detailVC.info = photos[indexPath.item].info
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension FavoritePhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item].info
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let hight = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: hight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}
