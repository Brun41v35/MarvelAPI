//
//  MarvelAPI.swift
//  
//
//  Created by Bruno Alves da Silva on 07/07/20.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    
    //Caso tenha algum problema, usar essa URL: https://gateway.marvel.com/v1/public/characters?
    //Base da URL
    static private let basePath = "http://gateway.marvel.com/v1/public/characters?"
    static private let privateKey = "39dc3acbe6b441db421bb6e7bfbd21696fda7817"
    static private let publicKey = "95f784d1ede496307f1ce79af222571f"
    static private let limit = 50
    
    class func loadHeros(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startsWith = ""
        }
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        print(url)
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                onComplete(marvelInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
}
