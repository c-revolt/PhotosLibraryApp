//
//  GalleryViewModel.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 25.04.2023.
//

import UIKit

final class GalleryViewModel: GalleryViewModelType {
    
    var photos: [Photo] = []
    var selectedImages = [UIImage]()
    var networkDataFetcher: NetworkDataFetcherType?
    
    var numberOfRows: Int {
        photos.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GalleryPhotoCellViewModelType? {
        let photo = photos[indexPath.item]
        return GalleryPhotoCellViewModel(model: photo)
    }
    
    func fetchResults(text searchText: String, collectionView: UICollectionView) {
        networkDataFetcher = NetworkDataFetcher()
        networkDataFetcher?.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
            collectionView.reloadData()
        }
    }
    
    func waterFallLayout(for indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        return CGSize(width: photo.width, height: photo.height)
    }
    
    func appendSelectedImages(_ image: UIImage) {
        selectedImages.append(image)
    }
    
    func removeSelectedImages(_ image: UIImage) {
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
}
