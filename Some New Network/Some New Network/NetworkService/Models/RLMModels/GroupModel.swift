//
//  GroupsModel.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 04.03.2022.
//

import Foundation
import RealmSwift

struct GroupsModel: Decodable {
    let response: GroupsResponse
}

struct GroupsResponse: Decodable {
    let count: Int
    let items: [GroupRealmModel]
}

class GroupRealmModel: Object, Decodable {
    
    //private let service = ServiceVK()
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var isMember = 0
    @objc dynamic var photo = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMember = "is_member"
        case photo = "photo_100"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
