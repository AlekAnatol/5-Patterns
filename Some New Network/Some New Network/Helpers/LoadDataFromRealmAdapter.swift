//
//  LoadDataFromRealmAdapter.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 24.06.2022.
//

import Foundation
import RealmSwift
import UIKit

class LoadDataFromRealmAdapter {
    private let realmService = RealmCacheService()
    
    // Загрузка друзей из реалма
    func loadFriendsFromRealm(tableView: UITableView, completion: @escaping ([Friend]) -> Void) -> NotificationToken {
        var friends =  [Friend]()
        var token = NotificationToken()
        
        DispatchQueue.main.async {
            var friendsFromRealm: Results<FriendsRealmModel>? {
                self.realmService.read(object: FriendsRealmModel.self)
            }
            
            guard let friendsFromRealm = friendsFromRealm else { return }
            friendsFromRealm.forEach { friendFromRealm in
                let friend = Friend (id: friendFromRealm.id,
                                     firstName: friendFromRealm.firstName,
                                     lastName: friendFromRealm.lastName,
                                     photoURL: friendFromRealm.photo50)
                friends.append(friend)
            }
            completion(friends)
            
            token = friendsFromRealm.observe { results in
                switch results {
                case .initial(_):
                    print("Token for friends controller initialized")
                    
                case .update(let friendsData,
                             deletions: let deletions,
                             insertions: let insertions,
                             modifications: let modifications):
                    
                    print("We have \(friendsData.count) friends")
                    
                    let deletionsIndexPath = deletions.map { IndexPath (row: $0, section: 0) }
                    let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                    let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0)}
                    
                    tableView.beginUpdates()
                    tableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                    tableView.insertRows(at: insertionsIndexPath, with: .automatic)
                    tableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                    tableView.endUpdates()
                    
                case .error(let error):
                    print("\(error)")
                }
            }
        }
        return token
    }
    
    //Функция загрузки фото для пользователя
    func loadPhotosFromRealm(friend: Friend, completion: @escaping ([Photo]) -> Void) {
        var photos = [Photo]()
        
        DispatchQueue.main.async {
            var photosFromRealm: Results<PhotoRealmModel>? {
                self.realmService.readPhotos(friendID: friend.id)
            }
            
            guard let photosFromRealm = photosFromRealm else { return }
            photosFromRealm.forEach { photoFromRealm in
                let photo = Photo(ownerID: photoFromRealm.ownerID,
                                  url: photoFromRealm.url,
                                  likesCount: photoFromRealm.likesCount)
                photos.append(photo)
            }
            completion(photos)
        }
    }
}
