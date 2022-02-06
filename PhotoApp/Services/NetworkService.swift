//
//  NetworkService.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkServices {
    func request(searchText: String, completion: @escaping (Result<UnsplashPhoto, NetworkError>) -> Void) {
        
        let parameters = self.prepareParameters(searchText: searchText)
        let url = self.url(parameters: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        let task = dataTask(from: request, completion: completion)
        
        task.resume()
    }
    
    private func prepareHeaders() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID hNxJZczsBzc3PIw__6xIFLbhh6SVj8CnCVPPPDi5hsU"
        return headers
    }
    
    private func prepareParameters(searchText: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchText
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func dataTask(from request: URLRequest, completion: @escaping (Result<UnsplashPhoto, NetworkError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let unsplashPhoto = try JSONDecoder().decode(UnsplashPhoto.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(unsplashPhoto))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }
}

