//
//  SelectedItemViewController.swift
//  PhotoApp
//
//  Created by Иван Гришин on 30.01.2022.
//

import UIKit

class DetailedInfoViewController: UIViewController {
    
    var info: PhotoInfo!
    var image: UIImage!
    var indexPath: Int!
    
    var deleteButtonIsActive: Bool = false
    
    //MARK: - UIElements
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteBarButtonTapped))
    }()
    
    lazy var contentViewSize:CGSize = {
        let withRatio = image.size.height / image.size.width
        let imageWidth =  view.frame.width - 32
        let viewSize = CGSize(width: self.view.frame.width, height: withRatio * imageWidth + 200)
        return viewSize
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
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
    
    //MARK: - ButtonsAction
    
    @objc private func addBarButtonTapped() {
        PersistenceManager.shared.saveInfos(photo: info)
        addBarButtonItem.isEnabled = false
    }
    
    @objc private func deleteBarButtonTapped() {
        
        let alertView = UIAlertController(title: "Удалить фото", message: "Вы уверены?", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            PersistenceManager.shared.infos.remove(at: self.indexPath)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - SetupVC
    
    func setupVC(){
        view.backgroundColor = .white
        title = info.description == nil ? "Image" : info.description
        navigationItem.rightBarButtonItem = setupButtons(favorites: PersistenceManager.shared.infos)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(labelAuthor)
        containerView.addSubview(labelDate)
        containerView.addSubview(labelDownloads)
        setupLayout()
    }
    
    func setupButtons(favorites: [PersistenceManager.FavoriteData]) -> UIBarButtonItem {
        var button = addBarButtonItem
        var objectInArray = 0
        
        if deleteButtonIsActive {
            button = deleteBarButtonItem
        } else {
            for item in favorites {
                if info.urls["regular"] == item.info.urls["regular"] {
                    objectInArray += 1
                } else {
                    button.isEnabled = true
                }
            }
        }
        
        if objectInArray >= 1 {
            button.isEnabled = false
        } else {
            button.isEnabled = true
        }

        return button
    }
    //MARK: - SetupLayout
    
    func setupLayout() {
        let withRatio = image.size.height / image.size.width
        let imageWidth =  view.frame.width - 32
        
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageWidth * withRatio).isActive = true
        
        
        labelAuthor.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        labelAuthor.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        labelAuthor.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        labelDate.topAnchor.constraint(equalTo: labelAuthor.bottomAnchor, constant: 10).isActive = true
        labelDate.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        labelDate.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        labelDownloads.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 10).isActive = true
        labelDownloads.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        labelDownloads.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
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
