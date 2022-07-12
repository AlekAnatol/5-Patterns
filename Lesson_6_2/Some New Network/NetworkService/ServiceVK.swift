//
//  ServiceVK.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 22.02.2022.
//

import Foundation
import RealmSwift
import FirebaseDatabase

class ServiceVK: ServiceVKProtocol {
    
    let sessionSinglton = Session.instance
    
    private var ref = Database.database().reference(withPath: "MyGroups")
    
    private let session: URLSession = {
        let configure = URLSessionConfiguration.default
        let session = URLSession(configuration: configure)
        return session
    }()
    
    private let scheme = "https"
    private let host = "api.vk.com"
    
    func loadData(method: ApiMethods) {
        
        var urlComponenets = urlSettings(method: method)
        urlComponenets.queryItems = queryItemsSettings(method: method)
        
        guard let url = urlComponenets.url  else {return}
        print(url)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error")
            }
            guard let data = data else {
                return
            }
            let jsonDecoder = JSONDecoder()
            
            DispatchQueue.main.async {
                
                if method == .friendsGet {
                    do {
                        let result = try jsonDecoder.decode(FriendsModel.self, from: data).response.items
                        self.saveInfoInRealm(info: result)
                    }
                    catch {
                        print("Error didn't decode Friends")
                    }
                    
                }   else  if method == .myGroupsGet  {
                    do {
                        let result = try jsonDecoder.decode(GroupsModel.self, from: data).response.items

                        result.forEach { group in
                            let firebaseGroups = FirebaseGroups(groupName: group.name, groupID: group.id)
                            let groupsPreparedName = group.name.preparationNameForFirebase()
                            let groupsRef = self.ref.child(groupsPreparedName.lowercased())
                            groupsRef.setValue(firebaseGroups.toAnyObject())
                        }
                        self.saveInfoInRealm(info: result)
                    }
                    catch {
                        print("Error didn't decode My Groups")
                    }
                }
                else  if method == .cookingGroupsGet {
                    do {
                        let result = try jsonDecoder.decode(GroupsModel.self, from: data).response.items
                        self.saveInfoInRealm(info: result)
                    }
                    catch {
                        print("Error didn't decode Cooking Groups")
                    }
                }
            }
        }
        task.resume()
    }
    
    func loadPhotos() -> () {
        
        //guard Session.instance.token != nil else { return }
        
        let session: URLSession = {
            let configure = URLSessionConfiguration.default
            let session = URLSession(configuration: configure)
            return session
        }()
        
        var urlComponenets = urlSettings(method: .getPhotos)
        urlComponenets.queryItems = queryItemsSettings(method: .getPhotos)
        
        guard let myFriends = readFriendsFromRealm() else { return }
        
        for friend in myFriends {
            urlComponenets.queryItems?.append(URLQueryItem(name: "owner_id", value: String(friend.id)))
            
            guard let url = urlComponenets.url  else {return}
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    var photosOfUser = [PhotoRealmModel]()
                    let newElement = PhotoRealmModel()
                    newElement.ownerID = friend.id
                    newElement.url = "Grisha"
                    newElement.likesCount = 0
                    photosOfUser.append(newElement)
                    self.saveInfoInRealm(info: photosOfUser)
                }
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let result = try jsonDecoder.decode(PhotosModel.self, from: data)
                        
                        if result.response.count == 0 {
                            return
                        } else {
                            var photosOfUser = [PhotoRealmModel]()
                            guard let response = result.response.items else {return}
                            
                            for photosResponse in response {
                                let newElement = PhotoRealmModel()
                                newElement.likesCount = photosResponse.likes.likesCount
                                for photoSize in photosResponse.sizes {
                                    if photoSize.type == "m" {
                                        newElement.ownerID = friend.id
                                        newElement.url = photoSize.url
                                        photosOfUser.append(newElement)
                                        self.saveInfoInRealm(info: photosOfUser)
                                    }
                                }
                            }
                        }
                    }
                    catch {
                        print("Error in loading photos")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func urlSettings(method: ApiMethods) -> URLComponents {
        var urlComponenets = URLComponents()
        urlComponenets.scheme = scheme
        urlComponenets.host = host
        urlComponenets.path = method.rawValue
        
        return urlComponenets
    }
    
    private func queryItemsSettings(method: ApiMethods) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        switch method {
        case .friendsGet:
            queryItems = [URLQueryItem(name: "access_token", value: Session.instance.token),
                          URLQueryItem(name: "v", value: "5.131"),
                          URLQueryItem(name: "count", value: "15"),
                          URLQueryItem(name: "fields", value: "photo_50")]
        case .myGroupsGet:
            queryItems = [URLQueryItem(name: "access_token", value: Session.instance.token),
                          URLQueryItem(name: "v", value: "5.131"),
                          URLQueryItem(name: "extended", value: "1")]
        case .cookingGroupsGet:
            queryItems = [URLQueryItem(name: "access_token", value: Session.instance.token),
                          URLQueryItem(name: "v", value: "5.131"),
                          URLQueryItem(name: "q", value: "Кулинария"),
                          URLQueryItem(name: "type", value: "group"),
                          URLQueryItem(name: "count", value: "10")]
        case .getPhotos:
            queryItems = [URLQueryItem(name: "access_token", value: Session.instance.token),
                          URLQueryItem(name: "album_id", value: "wall"),
                          URLQueryItem(name: "extended", value: "1"),
                          URLQueryItem(name: "v", value: "5.131"),
                          URLQueryItem(name: "count", value: "18")]
        }
        return queryItems
    }
}

extension ServiceVK {
    func saveInfoInRealm <T: Object> (info: [T]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            //print(realm.configuration.fileURL)
            realm.beginWrite()
            realm.add(info, update: .modified)
            try realm.commitWrite()
        }
        catch {
            print("ITS ERROR: \(error)")
        }
    }
    
    func readFriendsFromRealm() -> Results<FriendsRealmModel>? {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            return realm.objects(FriendsRealmModel.self)
        }
        catch {
            print("ITS ERROR: \(error)")
            return nil
        }
    }
    
}

extension String {
    func preparationNameForFirebase() -> String {
        var preparedName = self.replacingOccurrences(of: ".", with: "%%")
        preparedName = preparedName.replacingOccurrences(of: "#", with: "%%")
        preparedName = preparedName.replacingOccurrences(of: "$", with: "%%")
        preparedName = preparedName.replacingOccurrences(of: "[", with: "%%")
        preparedName = preparedName.replacingOccurrences(of: "]", with: "%%")
        if preparedName.isEmpty { return "THIS GROUP HAS NO NAME" }
        else { return preparedName }
    }
}
