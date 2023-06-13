//
//  Assembly.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 01.06.2023.
//

import UIKit

protocol AssemblyType: AnyObject {
    func makeGalleryView(output: GalleryViewOutput) -> UIViewController
    func makeFavoritsView(output: FavoritesOutput) -> UIViewController
}

final class Assembly: AssemblyType {
    
    func makeGalleryView(output: GalleryViewOutput) -> UIViewController {
        let viewModel = GalleryViewViewModel(output: output)
        let view = GalleryViewController(viewModel: viewModel)
        viewModel.view = view
        
        return view
    }
    
    func makeFavoritsView(output: FavoritesOutput) -> UIViewController {
        let viewModel = FavoritesViewViewModel(output: output)
        let view = FavoritesViewController(viewModel: viewModel)
        viewModel.view = view
        
        return view
    }
}
