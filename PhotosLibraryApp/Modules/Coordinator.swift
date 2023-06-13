//
//  Coordinator.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 01.06.2023.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
  
}

protocol CoordinatorProtocol: MainCoordinatorProtocol {
    func start(window: UIWindow)
}

final class AppCoordinator: CoordinatorProtocol {
    
    var assembly: AssemblyType
    weak var galleryOutput: GalleryViewOutput?
    weak var favoritesOutput: FavoritesOutput?
    
    init(assembly: AssemblyType) {
        self.assembly = assembly
    }
    
    func start(window: UIWindow) {
        
        let tabBarController = UITabBarController()
        
        let galleryViewController = assembly.makeGalleryView(output: self)
        let favoritesViewController = assembly.makeFavoritsView(output: self)
        
        tabBarController.setViewControllers(
            [
                UINavigationController(rootViewController: galleryViewController),
                UINavigationController(rootViewController: favoritesViewController)
            ],
            animated: true
        )
        
        setupTabBarController(tabBarController)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
      //  window.overrideUserInterfaceStyle = .dark
    }
    
    private func setupTabBarController(_ tabBarController: UITabBarController) {
        
        tabBarController.viewControllers?[0].tabBarItem = UITabBarItem(
            title: "Photos",
            image: UIImage(systemName: "film"),
            tag: 0)
        
        tabBarController.viewControllers?[1].tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            tag: 1)
        
        tabBarController.tabBar.tintColor = .systemGreen
    }
    
}

//
//final class Coordinator {
//    private let assembly: Assembly
//    private var navigationController: UINavigationController?
//
//    init(assembly: Assembly) {
//        self.assembly = assembly
//    }
//
//    func start(window: UIWindow) {
//        let galleryView = assembly.makeGalleryView(output: self)
//        navigationController = UINavigationController(rootViewController: galleryView)
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        window.overrideUserInterfaceStyle = .dark
//    }
//}

extension AppCoordinator: GalleryViewOutput {

}

extension AppCoordinator: FavoritesOutput {
    
}
