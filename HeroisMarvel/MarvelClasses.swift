//
//  MarvelClasses.swift
//  HeroisMarvel
//
//  Created by Bruno Alves da Silva on 07/07/20.
//  Copyright © 2020 Bruno Alves da Silva. All rights reserved.
//

import Foundation

struct MarvelInfo: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

struct Hero: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    let urls: [HeroURL]
}

struct Thumbnail: Codable {
    let path: String
    let ex: String
    
    var url: String {
        return path + "." + ex
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ex = "extension"
    }
}

struct HeroURL: Codable {
    let type: String
    let url: String
}
