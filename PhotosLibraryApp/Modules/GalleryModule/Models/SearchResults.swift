//
//  SearchResults.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 13.04.2023.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [Photo]
}

struct Photo: Decodable {
 //   let id: String
    let width: Int
    let height: Int
    let likes: Int
 //   let description: String
    let urls: [URLKing.RawValue:String]
    let user: User
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case width
//        case height
//        case likes
//        case description = "description"
//        case urls
//        case user
//    }
}

struct User: Decodable {
    let id: String
    let name: String
}
