//
//  FriendsModel.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 28.02.2022.
//

import Foundation
import RealmSwift

struct FriendsModel: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let count: Int
    let items: [FriendsRealmModel]
}

class FriendsRealmModel: Object, Decodable {
    
    private let service = ServiceVK()
    
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo50 = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
