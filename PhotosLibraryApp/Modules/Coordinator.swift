//
//  Coordinator.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 01.06.2023.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    var tabBarController: UITabBarController? { get set }
    var assembly: AssemblyType? { get set }
}

protocol CoordinatorProtocol: MainCoordinatorProtocol {
    func start(window: UIWindow)
}

final class AppCoordinator: CoordinatorProtocol {
    
    var tabBarController: UITabBarController?
    var assembly: AssemblyType?
    weak var galleryOutput: GalleryViewOutput?
    weak var favoritesOutput: FavoritesOutput?
    
    init(tabBarController: UITabBarController, assembly: AssemblyType) {
        self.tabBarController = tabBarController
        self.assembly = assembly
    }
    
    func start(window: UIWindow) {
        if let tabBarController = tabBarController {
            guard let galleryViewController = assembly?.makeGalleryView(output: galleryOutput!) else { return }
            guard let favoritesViewController = assembly?.makeFavoritsView(output: favoritesOutput!) else { return }
            tabBarController.setViewControllers(
                [
                    UINavigationController(rootViewController: galleryViewController),
                    UINavigationController(rootViewController: favoritesViewController)
                ],
                animated: true
            )
        }
        
        setupTabBarController()
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .dark
    }
    
    private func setupTabBarController() {
        
        tabBarController?.viewControllers?[0].tabBarItem = UITabBarItem(
            title: "Photos",
            image: UIImage(systemName: "film"),
            tag: 0)
        
        tabBarController?.viewControllers?[1].tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            tag: 1)
        
        tabBarController?.tabBar.tintColor = .systemGreen
    }
    
}


final class Coordinator {
    private let assembly: Assembly
    private var navigationController: UINavigationController?
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
    
    func start(window: UIWindow) {
        let galleryView = assembly.makeGalleryView(output: self)
        navigationController = UINavigationController(rootViewController: galleryView)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .dark
    }
}

extension Coordinator: GalleryViewOutput {
    
}

extension Coordinator: FavoritesOutput {
    
}
