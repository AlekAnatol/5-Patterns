//
//  AllGroupsViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 11.01.2022.
//

import UIKit
import RealmSwift

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupsTableView: UITableView!
    
    private let service = ServiceVKProxy()
    let dataLoader = LoadDataFromRealmAdapter()
    private var allGroups = [Group]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brandPink
        allGroupsTableView.dataSource = self
        allGroupsTableView.delegate = self
        allGroupsTableView.register(UINib(nibName: "Universal  TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            dataLoader.loadGroupsFromRealm(isMember: false) { allGroups in
            self.allGroups = allGroups
            self.allGroupsTableView.reloadData()
        }
    }
}

//MARK: - TableViewDataSource

extension AllGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count //?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = allGroupsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableViewCell, for: indexPath) as? Universal__TableViewCell
        else {return UITableViewCell()}
        cell.configure(group: allGroups[indexPath.row], completion: {[weak self] in
            guard let self = self else {return}
            print( self.allGroups[indexPath.row].name)
            self.dataLoader.addGroup(group: self.allGroups[indexPath.row])
            self.dataLoader.loadGroupsFromRealm(isMember: false) { groups in
                self.allGroups = groups
                self.allGroupsTableView.reloadData()
            }
        })
                       
        return cell
    }
}

//MARK: - TableViewDelegate

extension AllGroupsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
}
