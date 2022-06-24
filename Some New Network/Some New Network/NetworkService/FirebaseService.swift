//
//  FirebaseGroups.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 03.04.2022.
//

import Firebase

class FirebaseGroups {
    let groupName: String
    let groupID: Int
    let ref: DatabaseReference?
    
    init(groupName: String, groupID: Int) {
        self.groupName = groupName
        self.groupID = groupID
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard   let value = snapshot.value as? [String: Any],
                let name = value["groupName"] as? String,
                let id = value["groupID"] as? Int
        else {
            return nil
        }
        self.groupName = name
        self.groupID = id
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
       return ["groupName": groupName,
         "groupID": groupID]
    }
}

//class FirebaseUsers {
//    var userID: String?
//    var ref: DatabaseReference?
//    
//    init(userID: String) {
//        self.userID = userID
//        self.ref = nil
//    }
//    
//    init?(snapshot: DataSnapshot) {
//        guard   let value = snapshot.value as? [String: Any],
//                let id = value["userID"] as? String
//        else {
//            return nil
//        }
//        self.userID = id
//        self.ref = snapshot.ref
//    }
//    
//    func toAnyObject() -> [String: Any] {
//       return ["userID": userID]
//    }
//}
