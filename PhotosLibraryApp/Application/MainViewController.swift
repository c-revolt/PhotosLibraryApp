//
//  MainView.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 13.05.2023.
//

import UIKit

class MainView: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupViews()
        //setTabBarAppearance()
    }
    
    func generateTabBar() {
        viewControllers = [
            generateViewController(viewController: GalleryViewController(),
                                   title: "Gallery",
                                   image: UIImage(systemName: "house.fill") ?? UIImage()),
            generateViewController(viewController: FavoritesViewController(),
                                   title: "Favorites",
                                   image: UIImage(systemName: "star") ?? UIImage())
        ]
        
        let galleryVC = UINavigationController(rootViewController: GalleryViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        
    }
    
    private func setupViews() {
        let galleryVC = GalleryViewController()
        let favoritesVC = FavoritesViewController()
        
        
        galleryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Галлерея")
        favoritesVC.setTabBarImage(imageName: "star", title: "Избранное")
        
        
        let galleryNC = UINavigationController(rootViewController: galleryVC)
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
        
        
       // galleryNC.navigationBar.barTintColor = #colorLiteral(red: 0.1882352941, green: 0.8901960784, blue: 0.8745098039, alpha: 1)
        
        
        let tabBarList = [galleryNC, favoritesNC]
        
        viewControllers = tabBarList
        tabBar.tintColor = .systemTeal
        tabBar.unselectedItemTintColor = .lightGray
        setStatusBar()
    }
    
    func generateViewController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
                                                          y: tabBar.bounds.midY - positionOnY * 2,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.systemTeal.cgColor
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.backgroundColor = .clear
        navigationController?.title = "Gallery"
        navigationController?.navigationBar.tintColor = .systemBackground
    }
}
