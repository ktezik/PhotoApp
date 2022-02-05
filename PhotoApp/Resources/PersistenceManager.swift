//
//  Base.swift
//  PhotoApp
//
//  Created by Иван Гришин on 30.01.2022.
//

import Foundation

class PersistenceManager{
    let defaults = UserDefaults.standard
    
    static let shared = PersistenceManager()
    
    struct FavoriteData: Codable {
        var info: PhotoInfo
    }
    
    var infos: [FavoriteData] {
        get{
            if let data = defaults.value(forKey: "infos") as? Data{
                return try! PropertyListDecoder().decode([FavoriteData].self, from: data)
            } else {
                return [FavoriteData]()
            }
        }
        
        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "infos")
            }
        }
    }
    
    func saveInfos(photo: PhotoInfo) {
        
        let infoData = FavoriteData(info: photo)
        infos.insert(infoData, at: 0)
    }
    
}
