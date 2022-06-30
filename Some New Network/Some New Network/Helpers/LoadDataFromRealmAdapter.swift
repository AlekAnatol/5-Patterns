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
    private var viewModelFactory: ViewModelFactoryProtocol?
    
    // Загрузка друзей из реалма
    func loadFriendsFromRealm(tableView: UITableView, completion: @escaping ([Friend]) -> Void) {
        var friends =  [Friend]()
        //Определяем фабрику, которая возвращает модели типа Friend
        viewModelFactory = createViewModelFactory(typeOfFactory: .friend)
        //Загружаем из реалма всех друзей
        DispatchQueue.main.async {
            var friendsFromRealm: Results<FriendsRealmModel>? {
                self.realmService.read(object: FriendsRealmModel.self)
            }
            guard let friendsFromRealm = friendsFromRealm else { return }
            //Каждый элемент friendsFromRealm передаем в фабрику для формирования viewModel типа Friend
            friendsFromRealm.forEach { friendFromRealm in
                guard let friend = self.viewModelFactory?.createViewModel(dataFromRealm: friendFromRealm) as? Friend
                else { return}
                friends.append(friend)
            }
            completion(friends)
        }
    }
    
    //Загрузки фото для пользователя из реалма
    func loadPhotosFromRealm(friend: Friend, completion: @escaping ([Photo]) -> Void) {
        var photos = [Photo]()
        //Определяем фабрику, которая возвращает модели типа Photo
        viewModelFactory = createViewModelFactory(typeOfFactory: .photo)
        //Загружаем из реалма всех друзей
        DispatchQueue.main.async {
            var photosFromRealm: Results<PhotoRealmModel>? {
                self.realmService.readPhotos(friendID: friend.id)
            }
            guard let photosFromRealm = photosFromRealm else { return }
            //Каждый элемент photosFromRealm передаем в фабрику для формирования viewModel типа Photo
            photosFromRealm.forEach { photoFromRealm in
                guard let photo = self.viewModelFactory?.createViewModel(dataFromRealm: photoFromRealm) as? Photo
                else { return }
                photos.append(photo)
            }
            completion(photos)
        }
    }
    
    //Загрузка групп из реалма
    func loadGroupsFromRealm(isMember: Bool, completion: @escaping ([Group]) -> Void) {
        var groups =  [Group]()
        //Определяем фабрику, которая возвращает модели типа Group
        viewModelFactory = createViewModelFactory(typeOfFactory: .group)
        //Загружаем из реалма все интересующие нас группы
        DispatchQueue.main.async {
            var groupsFromRealm: Results<GroupRealmModel>? {
                self.realmService.readGroups(isMember: isMember)
            }
            guard let groupsFromRealm = groupsFromRealm else { return }
            //Каждый элемент groupsFromRealm передаем в фабрику для формирования viewModel типа Group
            groupsFromRealm.forEach { groupFromRealm in
                guard let group = self.viewModelFactory?.createViewModel(dataFromRealm: groupFromRealm) as? Group
                else { return }
                groups.append(group)
            }
            completion(groups)
        }
    }
    
    //Удалаяем группу из "Моих групп"
    func deleteGroup(group: Group) {
        let groupFromRealm = realmService.readOneGroup(group: group)
        guard let groupFromRealm: GroupRealmModel = groupFromRealm.last else { return }
        realmService.deleteGroupFromMyGroups(group: groupFromRealm)
    }
    
    //Добавляем группу в "Мои группы"
    func addGroup(group: Group) {
        let groupFromRealm = realmService.readOneGroup(group: group)
        guard let groupFromRealm: GroupRealmModel = groupFromRealm.last else { return }
        realmService.addGroupToMyGroups(group: groupFromRealm)
    }
}
