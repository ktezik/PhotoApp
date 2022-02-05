//
//  NetworkFetcher.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import Foundation

class NetworkFetcher {
    
    var networkService = NetworkServices()
    
    func fetchImages(searchText: String, completion: @escaping (UnsplashPhoto?) -> ()) {
        networkService.request(searchText: searchText) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJson(type: UnsplashPhoto.self, from: data)
            completion(decode)
        }
    }
    func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print("Failed decode", error)
            return nil
        }
    }
    
}
