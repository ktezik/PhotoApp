//
//  UnsplashModel.swift
//  PhotoApp
//
//  Created by Иван Гришин on 29.01.2022.
//

import Foundation

struct UnsplashPhoto: Decodable {
    let results: [PhotoInfo]
}

struct PhotoInfo: Codable {
    let width: Int
    let height: Int
    let created_at: String?
    let likes: Int
    let description: String?
    let user: User?
    let urls: [URLs.RawValue:String]
}

struct User: Codable {
    let name: String
}

enum URLs: String {
    case raw
    case full
    case regular
    case small
    case thumb
}


