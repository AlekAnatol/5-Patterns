//
//  AllGroupsViewController+TableDataSource.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 13.01.2022.
//

import UIKit
import FirebaseDatabase

extension AllGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupsFromRealm?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = allGroupsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableViewCell, for: indexPath) as? Universal__TableViewCell
        else {return UITableViewCell()}
        
        guard let allGroupsFromRealm = self.allGroupsFromRealm else {
             cell.configure(image: UIImage(named: "1"), name: "Kitty Gav", description: "")
             return cell
        }
        
        cell.configure(group: allGroupsFromRealm[indexPath.row], completion: {[weak self] in
            guard let self = self else {return}
            
            let firebaseGroup = FirebaseGroups(groupName: allGroupsFromRealm[indexPath.row].name,
                                           groupID: allGroupsFromRealm[indexPath.row].id)
            let firebaseGroupPreparedName = allGroupsFromRealm[indexPath.row].name.preparationNameForFirebase()
            let firebaseUserRef = Session.instance.sessionUserRef.child("Added Groups")
            let firebaseGroupRef = firebaseUserRef.child(firebaseGroupPreparedName)
            firebaseGroupRef.setValue(firebaseGroup.toAnyObject())
            
            
            DispatchQueue.main.async {
                self.realm.addGroupToMyGroups(group: allGroupsFromRealm[indexPath.row])
            }
        })
        return cell
    }
}
