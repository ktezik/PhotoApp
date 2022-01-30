//
//  Base.swift
//  PhotoApp
//
//  Created by Иван Гришин on 30.01.2022.
//

import Foundation

class Base{
    let defaults = UserDefaults.standard
    
    static let shared = Base()
    
    struct FavoriteData: Codable {
        var info: Photo
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
    
    func saveInfos(photo: Photo) {
        
        let infoData = FavoriteData(info: photo)
        infos.insert(infoData, at: 0)
    }
    
}
