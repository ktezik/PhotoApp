//
//  ViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoVC = RandomPhotosCollectionViewController(collectionViewLayout: UICollectionViewLayout())
        let favoriteVC = FavoritePhotosCollectionViewController(collectionViewLayout: UICollectionViewLayout())
        
        self.setViewControllers([generateNavigationVC(viewController: photoVC, title: "Photo", systemImageName: "photo"), generateNavigationVC(viewController: favoriteVC, title: "Favorite", systemImageName: "heart.rectangle")], animated: false)
        
        self.tabBar.tintColor = .black
    }
    
    private func generateNavigationVC(viewController: UIViewController, title: String, systemImageName: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: systemImageName)
        return navigationVC
    }
    
}