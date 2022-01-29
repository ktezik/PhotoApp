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
        
        setTabBarController()
    }
    
    func setTabBarController() {
        let homeVC = UINavigationController(rootViewController: RandomPhotosTableViewController())
        homeVC.title = "Photo"
        let secondVC = UINavigationController(rootViewController: FavoritePhotosTableViewController())
        secondVC.title = "Favorite"
        
        self.setViewControllers([homeVC, secondVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let image = ["photo", "heart.rectangle"]
        
        for index in 0...(items.count - 1) {
            items[index].image = UIImage(systemName: image[index])
        }
        
        self.tabBar.tintColor = .black
//        self.tabBar.ima
    }
    
}
