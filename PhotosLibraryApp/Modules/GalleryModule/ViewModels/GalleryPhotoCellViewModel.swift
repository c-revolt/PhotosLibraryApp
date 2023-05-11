//
//  GalleryPhotoCellViewModel.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 25.04.2023.
//

import UIKit

final class GalleryPhotoCellViewModel: GalleryPhotoCellViewModelType {
   
    private var model: Photo
    
    var photoString: String {
        guard let imageUrl = model.urls["regular"] else { fatalError() }
        return imageUrl
    }
    
    var photoAuthorString: String {
        return model.user.name
    }
    
    init(model: Photo) {
        self.model = model
    }
}
