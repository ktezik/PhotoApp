//
//  SecondSelectedViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 30.01.2022.
//


import UIKit

class SecondSelectedViewController: UIViewController {
    
    var info: Photo!
    var image: UIImage!
    var indexPath: Int!
    
    //MARK: - UIElements
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBarButtonTapped))
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelAuthor: UITextView = {
        textLabel(font: UIFont.boldSystemFont(ofSize: 16), text: "Author: \(info.user?.name ?? "-")")
    }()
    
    private lazy var labelDate: UITextView = {
        textLabel(font: UIFont.systemFont(ofSize: 15), text: "Date of create: \(info.created_at ?? "-")")
    }()
    
    private lazy var labelDownloads: UITextView = {
        textLabel(font: UIFont.systemFont(ofSize: 15), text: "Download:  \(info.likes)")
    }()

    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
    }
    
    //MARK: - Button
    
    @objc private func deleteBarButtonTapped() {
        Base.shared.infos.remove(at: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - SetupVC
    
    func setupVC(){
        view.backgroundColor = .white
        title = info.description == "" ? "Image" : info.description
        navigationItem.rightBarButtonItem = deleteBarButtonItem
        
        view.addSubview(imageView)
        view.addSubview(labelAuthor)
        view.addSubview(labelDate)
        view.addSubview(labelDownloads)
        setupLayout()
    }
    
    //MARK: - SetupLayout
    
    func setupLayout() {
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: CGFloat(info.width / 15)).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: CGFloat(info.height / 15)).isActive = true
        
        labelAuthor.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        labelAuthor.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        labelAuthor.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        labelDate.topAnchor.constraint(equalTo: labelAuthor.bottomAnchor, constant: 10).isActive = true
        labelDate.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        labelDate.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        labelDownloads.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 10).isActive = true
        labelDownloads.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        labelDownloads.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func textLabel(font: UIFont, text: String) -> UITextView {
        let labelView = UITextView()
        labelView.text = text
        labelView.font = font
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.textAlignment = .center
        labelView.isEditable = false
        labelView.isScrollEnabled = false
        return labelView
    }
}
