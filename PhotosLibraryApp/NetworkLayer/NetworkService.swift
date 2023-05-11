//
//  NetworkService.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.04.2023.
//

import Foundation

protocol NetworkServiceType: AnyObject {
    func searchRequest(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: NetworkServiceType {
    func searchRequest(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareSearchParameters(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = prepareHeader()
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 1NoWwO0OZHXZdPNNyvKXYauNb2-tjwKquC9O-dIB0c0"
        print(headers)
        return headers
    }
    
    private func prepareSearchParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(45)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        guard let url = components.url else { fatalError() }
        print(url)
        return url
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
