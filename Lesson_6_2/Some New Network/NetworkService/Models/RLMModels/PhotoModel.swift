//
//  PhotosModel.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 03.03.2022.
//

import Foundation
import RealmSwift

struct PhotosModel: Decodable {
    let response: PhotosResponse
}

struct PhotosResponse: Decodable {
    let count: Int
    let items: [PhotoInfo]?
}

struct PhotoInfo: Decodable {
    let ownerID: Int
    let sizes: [Size]
    let likes: LikesResponse
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
        case likes
    }
    
}

struct Size: Decodable {
    let url: String
    let type: String
}

struct LikesResponse: Decodable {
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case likesCount = "count"
    }
}

class PhotoRealmModel: Object {
    @objc dynamic var ownerID = 0
    @objc dynamic var url = ""
    @objc dynamic var likesCount = 0
    
    override class func primaryKey() -> String? {
        return "url"
    }
}
