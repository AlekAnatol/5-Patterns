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
    var realm = RealmCacheService()
    private var token: NotificationToken?
    
    private let firebaseService = [FirebaseGroups]()
    let ref = Database.database().reference(withPath: "Groups")
    
    var myGroupsFromRealm: Results<GroupRealmModel>? {
        realm.readGroups(isMember: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myGroupsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.brandPink
        super.viewDidLoad()
        
        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
        
        myGroupsTableView.register(UINib(nibName: "Universal  TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableViewCell)
        
        service.loadData(method: .cookingGroupsGet)
        createNotificationToken()
        
        ref.observe(.value) { snapshot in
            var groups:[FirebaseGroups] = []
            for child in snapshot.children {
                if let snapshop = child as? DataSnapshot,
                    let group = FirebaseGroups(snapshot: snapshot) {
                    groups.append(group)
                }
            }
            groups.forEach { print($0.groupName)}
        }
    }
}

private extension MyGroupsViewController{
    
    func createNotificationToken() {
        token = myGroupsFromRealm?.observe { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .initial(let myGroupsData):
                print("We have \(myGroupsData.count) groups")
                
            case .update(let myGroupsData, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                print("We have \(myGroupsData.count) groups")
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.myGroupsTableView.beginUpdates()
                    self.myGroupsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                    self.myGroupsTableView.insertRows(at: insertionsIndexPath, with: .automatic)
                    self.myGroupsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                    self.myGroupsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
            
        }
    }
}
