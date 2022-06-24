//
//  MyGroupsViewController+TableViewDelegate.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 13.01.2022.
//

import UIKit
import FirebaseDatabase

extension MyGroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let myGroupsFromRealm = myGroupsFromRealm else {
            print("NO MY GROUPS")
            return }
        
//        let groupPreparedName = myGroupsFromRealm[indexPath.row].name.preparationNameForFirebase()
//        let firebaseGroup = FirebaseGroups(groupName: groupPreparedName,
//                                            groupID: myGroupsFromRealm[indexPath.row].id)
//        
//        let groupRef = self.ref.child(groupPreparedName.lowercased())
//        print(firebaseGroup.toAnyObject())
//        groupRef.setValue(firebaseGroup.toAnyObject())
        
        print(myGroupsFromRealm[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        guard let myGroupsFromRealm = self.myGroupsFromRealm else { return }
        realm.deleteGroupFromMyGroups(group: myGroupsFromRealm[indexPath.row])
    }
}
