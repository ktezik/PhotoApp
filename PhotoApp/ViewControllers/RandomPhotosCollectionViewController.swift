//
//  HomeViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import UIKit

class RandomPhotosCollectionViewController: UICollectionViewController {

    var networkFetcher = NetworkFetcher()
    private var timer: Timer?
    
    private var photos: [Photo] = []
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButton))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
    }
    
    @objc private func addBarButton() {
        
    }
    
    //MARK: - SetupMethods
    
    private func setupNavigationBar() {
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    private func setupCollectionView() {
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.frame = view.bounds
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
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
}

    //MARK: - UISearchBarDelegate

extension RandomPhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkFetcher.fetchImages(searchText: searchText) { [weak self] searchResults in
                guard let fetchesPhotos = searchResults else { return }
                self?.photos = fetchesPhotos.results
                print(fetchesPhotos.results.count)
//                searchResults?.results.map({ (photo) in
//                    print(photo.urls["regular"], photo.urls)
//                })
                self?.collectionView.reloadData()
            }
        })
    }
}
