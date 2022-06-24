//
//  MyGroupsViewController+TableDataSource.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 13.01.2022.
//

import UIKit


extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsFromRealm?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myGroupsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableViewCell, for: indexPath) as? Universal__TableViewCell
        else {return UITableViewCell()}
        
        
        guard let myGroupsFromRealm = self.myGroupsFromRealm else {
             cell.configure(image: UIImage(named: "1"), name: "Kitty Gav", description: "")
             return cell
        }
        cell.configure(group: myGroupsFromRealm[indexPath.row], completion: {
            print(myGroupsFromRealm[indexPath.row].name)
        })
        return cell
    }
}
