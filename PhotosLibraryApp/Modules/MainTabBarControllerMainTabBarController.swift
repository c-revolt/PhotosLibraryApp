//
//  MainTabBarController.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.04.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
    }
    
    func setupTabBar() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            //appearance.backgroundColor = UIColor.systemBackground
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
            
            viewControllers = [
                generateVC(view: GalleryViewController(),
                           title: "Gallery",
                           image: UIImage(systemName: "house")),
                generateVC(view: FavoritesViewController(),
                           title: "Favorite",
                           image: UIImage(systemName: "star"))
            ]
            
        } else {
            viewControllers = [
                generateVC(view: GalleryViewController(),
                           title: "Home",
                           image: UIImage(systemName: "house")),
                generateVC(view: FavoritesViewController(),
                           title: "Favorite",
                           image: UIImage(systemName: "star"))
            ]
        }
        
    }

    private func generateVC(view: UIViewController, title: String, image: UIImage?) -> UIViewController {
        
        if #available(iOS 15, *) {
            
            view.tabBarItem.title = title
            view.tabBarItem.image = image
            view.navigationItem.title = title
            return view
        } else {
            let navigationController = UINavigationController(rootViewController: view)
            navigationController.tabBarItem.title = title
            navigationController.tabBarItem.image = image
            return navigationController
        }
    }
}
