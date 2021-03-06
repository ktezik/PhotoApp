//
//  HomeViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    var networkFetcher = NetworkServices()
    private var timer: Timer?
    
    private var photos: [PhotoInfo] = []
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        setupFirsLoad()
    }
    
    //MARK: - SetupMethods
    private func setupFirsLoad() {
        networkFetcher.request(searchText: "random") { randomPhoto in
            switch randomPhoto {
            case .success(let fetchesPhoto):
                self.photos = fetchesPhoto.results
                self.collectionView.reloadData()
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func setupNavigationBar() {
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: - UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        let photo = photos[indexPath.item]
        cell.photo = photo
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        guard let image = cell.photoImageView.image else { return }
        
        let detailVC = DetailedInfoViewController()
        
        detailVC.image = image
        detailVC.info = photos[indexPath.item]
        detailVC.indexPath = indexPath.item
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

    //MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            self.networkFetcher.request(searchText: searchText) { [weak self] unsplashPhoto in
                switch unsplashPhoto {
                case .success(let fetchesPhotos):
                    self?.photos = fetchesPhotos.results
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        })
    }
}

    //MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
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
