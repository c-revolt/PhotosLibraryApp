//
//  GalleryPhotoCellViewModelType.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 25.04.2023.
//

import UIKit

protocol GalleryPhotoCellViewModelType: AnyObject {
    var photoString: String { get }
    var photoAuthorString: String { get }
    var isSelected: Bool? { get }
}
