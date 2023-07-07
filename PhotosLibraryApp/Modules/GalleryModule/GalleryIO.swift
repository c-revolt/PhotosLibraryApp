//
//  GalleryIO.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 01.06.2023.
//

import Foundation

protocol GalleryViewInput: AnyObject {
    func showSharedSheet(_ sender: AnyObject)
    func showAddFavoriteAlert()
    func updateNavButtonState()
    func reloadCollection()
    func refresh()
}

protocol GalleryViewOutput: AnyObject {
    
}
