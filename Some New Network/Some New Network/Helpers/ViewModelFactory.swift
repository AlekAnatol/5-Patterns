//
//  ViewModelFactory.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 29.06.2022.
//

import UIKit
import RealmSwift

enum ViewModelType {
    case friend
    case group
    case photo
}

//Функция, создающая фабрику в зависимости от тогоБ как объект она доложна возвращать: Group, Friend или Photo
func createViewModelFactory(typeOfFactory: ViewModelType) -> ViewModelFactoryProtocol {
    switch typeOfFactory {
    case .friend:
        return FriendFactory()
    case .group:
        return GroupFactory()
    case .photo:
        return PhotoFactory()
    }
}

//Протокол на который подписаны наши ViewModel: Group, Friend или Photo
protocol ViewModelProtocol {
}

//Протокол на который подписаны наши фабрики
protocol ViewModelFactoryProtocol {
    func createViewModel(dataFromRealm: Object) -> ViewModelProtocol
}

//Фабрика для создания ViewModel типа Group
class GroupFactory: ViewModelFactoryProtocol {
    func createViewModel(dataFromRealm: Object) -> ViewModelProtocol {
        guard let groupFromRealm = dataFromRealm as? GroupRealmModel else {
            let image = UIImage(named: "1")
            return Group(id: 0, name: "0", isMember: false, photo: image)
        }
        let image = loadImage(urlString: groupFromRealm.photo)
        let group = Group(id: groupFromRealm.id,
                          name: groupFromRealm.name,
                          isMember: groupFromRealm.isMember != 0,
                          photo: image)
        return group
    }
}

//Фабрика для создания ViewModel типа Friend
class FriendFactory: ViewModelFactoryProtocol {
    func createViewModel(dataFromRealm: Object) -> ViewModelProtocol {
        guard let friendFromRealm = dataFromRealm as? FriendsRealmModel else {
            let image = UIImage(named: "1")
            return Friend(id: 0, firstName: "0", lastName: "0", photo: image)
        }
        let image = loadImage(urlString: friendFromRealm.photo50)
        let friend = Friend(id: friendFromRealm.id,
                            firstName: friendFromRealm.firstName,
                            lastName: friendFromRealm.lastName,
                            photo: image)
        return friend
    }
}

//Фабрика для создания ViewModel типа Photo
class PhotoFactory: ViewModelFactoryProtocol {
    func createViewModel(dataFromRealm: Object) -> ViewModelProtocol {
        guard let photoFromRealm = dataFromRealm as? PhotoRealmModel else {
            let image = UIImage(named: "1")
            return Photo(ownerID: 0, photo: image, likesCount: 0)
        }
        let image = loadImage(urlString: photoFromRealm.url)
        let photo = Photo(ownerID: photoFromRealm.ownerID,
                          photo: image,
                          likesCount: photoFromRealm.likesCount)
        return photo
    }
}


//Функция загрузки фотографии по ссылке url
func loadImage(urlString: String) -> UIImage? {
    let url = URL(string: urlString)
    if let data = try? Data(contentsOf: url!) {
        return UIImage(data: data)
    } else {
        return UIImage(named: "1")
    }
}
