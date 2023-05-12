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
    
    func numberOfRows() -> Int {
        return photos.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritePhotoCellViewModelType? {
        let photo = photos[indexPath.item]
        return FavoritePhotoCellViewModel(model: photo)
    }
    
    func appendSelectedImages(_ photo: [Photo]) {
        photos.append(contentsOf: photo)
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
