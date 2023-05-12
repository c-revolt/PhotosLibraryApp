//
//  FavoritesViewViewModelType.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 11.05.2023.
//

import UIKit

protocol FavoritesViewViewModelType: AnyObject {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoritePhotoCellViewModelType?
    func appendSelectedImages(_ image: [Photo])
    func reloadDataForAddBarButton(_ collectionView: UICollectionView)
}
