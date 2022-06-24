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
    
    private let service = ServiceVK()
    let realm = RealmCacheService()
    private var token: NotificationToken?
    
    var allGroupsFromRealm: Results<GroupRealmModel>? {
        realm.readGroups(isMember: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brandPink
        
        allGroupsTableView.dataSource = self
        allGroupsTableView.delegate = self
        
        allGroupsTableView.register(UINib(nibName: "Universal  TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableViewCell)

        createNotificationToken()
    }
}

private extension AllGroupsViewController {
    
    func createNotificationToken() {
        token = allGroupsFromRealm?.observe { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .initial(let allGroupsData):
                print("We have \(allGroupsData.count) groups to add")
                
            case .update(let allGroupsData, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                print("We have \(allGroupsData.count) groups to add")
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.allGroupsTableView.beginUpdates()
                    self.allGroupsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                    self.allGroupsTableView.insertRows(at: insertionsIndexPath, with: .automatic)
                    self.allGroupsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                    self.allGroupsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
            
        }
    }
}
