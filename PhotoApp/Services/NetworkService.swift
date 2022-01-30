//
//  NetworkService.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import Foundation

class NetworkServices {
    func request(searchText: String, completion: @escaping (Data?, Error?) -> Void) {
        
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
    
    private func dataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

