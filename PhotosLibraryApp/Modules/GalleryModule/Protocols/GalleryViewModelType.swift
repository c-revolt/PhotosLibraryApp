//
//  GalleryViewModelType.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 25.04.2023.
//

import UIKit

protocol GalleryViewModelType: AnyObject {
    var selectedImages: [UIImage] { get set }
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GalleryPhotoCellViewModelType?
    func fetchResults(text searchText: String, collectionView: UICollectionView)
    func waterFallLayout(for indexPath: IndexPath) -> CGSize
    func appendSelectedImages(_ image: UIImage)
    func removeSelectedImages(_ image: UIImage)
    func getPhotosForAddBarButton(forIndexPath indexPath: IndexPath) -> Photo
    //func appendSelectedImagesForFavorites(_ collectionView: UICollectionView)
}
