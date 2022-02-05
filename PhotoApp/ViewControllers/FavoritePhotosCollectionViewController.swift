//
//  FavoritPhotosTableViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var photos = PersistenceManager.shared.infos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let photo = PersistenceManager.shared.infos
        photos = photo
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let vc = PhotoCell()
        vc.photo = photos[indexPath.row].info
        
        let image = vc.photoImageView.image
       
        content.image = image
        content.text = photos[indexPath.row].info.user?.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = PhotoCell()
        vc.photo = photos[indexPath.row].info
        
        let image = vc.photoImageView.image

        let detailVC = DetailedInfoViewController()

        detailVC.indexPath = indexPath.row
        detailVC.image = image
        detailVC.info = photos[indexPath.item].info
        detailVC.deleteButtonIsActive = true
        navigationController?.pushViewController(detailVC, animated: true)

    }
}
