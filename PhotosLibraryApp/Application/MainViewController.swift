//
//  MainViewController.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 13.05.2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let galleryVC = GalleryViewController()
        let favoritesVC = FavoritesViewController()
        
        
        galleryVC.setTabBarImage(imageName: "photo.artframe", title: "Галерея")
        favoritesVC.setTabBarImage(imageName: "star", title: "Избранное")
        
        let galleryNC = UINavigationController(rootViewController: galleryVC)
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
    
        let tabBarList = [galleryNC, favoritesNC]
        
        viewControllers = tabBarList
        tabBar.tintColor = .systemTeal
        tabBar.unselectedItemTintColor = .lightGray
        setStatusBar()
    }
}
