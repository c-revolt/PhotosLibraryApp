//
//  NetworkDataFetcher.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 13.04.2023.
//

import Foundation

protocol NetworkDataFetcherType: AnyObject {
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ())
}

final class NetworkDataFetcher: NetworkDataFetcherType {
    
     var networkService: NetworkServiceType?
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService = NetworkService()
        networkService?.searchRequest(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("❌ \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
            
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonEerror {
            debugPrint(jsonEerror)
            return nil
        }
    }
    
    
}
