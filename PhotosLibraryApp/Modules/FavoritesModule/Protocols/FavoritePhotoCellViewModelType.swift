//
//  FavoritePhotoCellViewModelType.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.05.2023.
//

import Foundation

protocol FavoritePhotoCellViewModelType: AnyObject {
    var photoString: String { get }
    func set(photo: Photo) -> String
}
