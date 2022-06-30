//
//  Enums.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 25.02.2022.
//

import Foundation

enum ApiMethods: String {
    case friendsGet = "/method/friends.get"
    case myGroupsGet = "/method/groups.get"
    case cookingGroupsGet = "/method/groups.search"
    case getPhotos = "/method/photos.get"
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
}



