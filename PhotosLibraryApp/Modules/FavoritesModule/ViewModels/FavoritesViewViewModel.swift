//
//  FavoritesViewViewModel.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 11.05.2023.
//

import UIKit

final class FavoritesViewViewModel: FavoritesViewViewModelType {

    var photos: [Photo] = []
    var selectedImages = [UIImage]()
    weak var view: FavoritesViewControllerType?
    weak var ouput: FavoritesOutput?
    
    init(view: FavoritesViewControllerType? = nil, output: FavoritesOutput? = nil) {
        self.view = view
        self.ouput = output
    }
    
    func numberOfRows() -> Int {
        return photos.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritePhotoCellViewModelType? {
        let photo = photos[indexPath.item]
        return FavoritePhotoCellViewModel(model: photo)
    }
    
    func appendSelectedImages(_ image: [Photo]) {
        photos.append(contentsOf: image)
        
    }
    
    
    func removeSelectedImages(_ image: UIImage) {
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
    
    func reloadDataForAddBarButton(_ collectionView: UICollectionView) {
        collectionView.reloadData()
    }
    
}
