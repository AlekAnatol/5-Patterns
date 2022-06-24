//
//  RealmCasheService.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 15.03.2022.
//

import RealmSwift
import Foundation

final class RealmCacheService {
    enum Errors: Error {
        case noRealmObject(String)
        case noPrimaryKey(String)
        case failedToRead(String)
    }

    var realm: Realm

    init() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            self.realm = try Realm(configuration: config)
            print(realm.configuration.fileURL ?? "")
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func read<T: Object>(object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }

    func read<T: Object>(object: T.Type, key: String = "", completion: @escaping (Result<T, Error>) -> Void) {
        if let result = realm.object(ofType: T.self, forPrimaryKey: key) {
            completion(.success(result))
        } else {
            completion(.failure(Errors.failedToRead("Failed To Read Object")))
        }
    }
    
    func readPhotos(friendID: Int)-> Results<PhotoRealmModel> {
        return realm.objects(PhotoRealmModel.self).filter("ownerID == %@", friendID)
    }
    
    func readGroups(isMember: Bool) -> Results<GroupRealmModel> {
        return isMember ? realm.objects(GroupRealmModel.self).filter("isMember = 1") : realm.objects(GroupRealmModel.self).filter("isMember = 0")
    }
    
    func isMemberOfGroup(group: GroupRealmModel) -> Bool {
        return group.isMember == 1 ? true : false
    }
    
    func addGroupToMyGroups(group: GroupRealmModel) {
        do {
            realm.beginWrite()
            print(" begin add group in realm")
            group.isMember = 1
            realm.add(group, update: .modified)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
    
    func deleteGroupFromMyGroups(group: GroupRealmModel) {
        do {
            realm.beginWrite()
            print(" begin delete group in realm")
            group.isMember = 0
            realm.add(group, update: .modified)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }

}

