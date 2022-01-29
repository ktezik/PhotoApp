//
//  FavoritPhotosTableViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import UIKit

class FavoritePhotosCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
