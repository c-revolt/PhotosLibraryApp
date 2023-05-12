//
//  FavoritePhotoCellViewModel.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.05.2023.
//

import UIKit

final class FavoritePhotoCellViewModel: FavoritePhotoCellViewModelType {
   
    private var model: Photo
    
    var photoString: String {
        guard let imageUrl = model.urls["full"] else { fatalError() }
        return imageUrl
    }
    
    init(model: Photo) {
        self.model = model
    }
    
    func set(photo: Photo) -> String {
        let photoUrl = photo.urls["full"]
        guard let photoURL = photoUrl else { fatalError() }
        return photoURL
    }
}


