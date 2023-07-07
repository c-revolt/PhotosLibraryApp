//
//  GalleryViewModel.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 25.04.2023.
//

import Foundation

//protocol GalleryViewing: AnyObject {
//    func showSharedSheet(_ sender: AnyObject)
//    func showAddFavoriteAlert()
//    func updateNavButtonState()
//    func reloadCollection()
//    func refresh()
//}

final class GalleryViewViewModel {
    
    var photos: [Photo] = []
    var selectedImages: [Photo] = []
    var cellViewModelArray: [GalleryPhotoCellViewModel] = []
    var networkDataFetcher: NetworkDataFetcherType?
    weak var view: GalleryViewInput?
    weak var output: GalleryViewOutput?

    init(output: GalleryViewOutput? = nil) {
        self.output = output
    }

    
    func numberOfRows() -> Int {
        photos.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GalleryPhotoCellViewModel? {
        let photo = photos[indexPath.item]
        // selectedImages.contains(where: { $0.urls == photo.urls })
        // заменить selectedPhotos на IndexPath
        // сравниваем их по indexPath
        return GalleryPhotoCellViewModel(
            isSelected: selectedImages.contains(where: { $0.urls == photo.urls }),
            photoString: photo.urls["regular"]!,
            photoAuthorString: photo.user.name
        )
    }
    
    func fetchResults(text searchText: String) {
        networkDataFetcher = NetworkDataFetcher()
        networkDataFetcher?.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
            guard let fetchedPhotos = searchResults else { return }
            self?.photos = fetchedPhotos.results
            self?.view?.reloadCollection()
        }
    }
    
    func waterFallLayout(for indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        return CGSize(width: photo.width, height: photo.height)
    }
    
    func appendSelectedImages(_ indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        selectedImages.append(photo)
        // заменить на indexPath
        view?.updateNavButtonState()
        view?.reloadCollection()
    }
    
    func removeSelectedImages(_ indexPath: IndexPath) {
//        if let index = selectedImages.firstIndex(of: indexPath) {
//            selectedImages.remove(at: index)
//        }
    }
    
    func getPhotosForAddBarButton(forIndexPath indexPath: IndexPath) -> Photo {
        return photos[indexPath.item]
    }
}
