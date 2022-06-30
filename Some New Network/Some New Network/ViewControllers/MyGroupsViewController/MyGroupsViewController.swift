//
//  MyGroupsViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 11.01.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var myGroupsTableView: UITableView!
    
    private let service = ServiceVK()
    private var myGroups = [Group]()
    let dataLoader = LoadDataFromRealmAdapter()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.brandPink
        super.viewDidLoad()
        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
        myGroupsTableView.register(UINib(nibName: "Universal  TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableViewCell)
        service.loadData(method: .cookingGroupsGet)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            dataLoader.loadGroupsFromRealm(isMember: true) { allGroups in
            self.myGroups = allGroups
            self.myGroupsTableView.reloadData()
        }
    }
}

//MARK: - TableViewDataSource

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count //?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myGroupsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableViewCell, for: indexPath) as? Universal__TableViewCell
        else { return UITableViewCell() }
        cell.configure(group: myGroups[indexPath.row]) {
            print(self.myGroups[indexPath.row].name)
        }
        return cell
    }
}

//MARK: - TableViewDelegate

extension MyGroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //guard let myGroups = self.myGroups else { return }
        print("Хотим удалить группу \(myGroups[indexPath.row])")
        dataLoader.deleteGroup(group: myGroups[indexPath.row])
        
        dataLoader.loadGroupsFromRealm(isMember: true) { groups in
            self.myGroups = groups
            self.myGroupsTableView.reloadData()
        }
    }
}
