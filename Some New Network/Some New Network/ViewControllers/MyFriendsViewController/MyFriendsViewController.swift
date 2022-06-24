//
//  MyFriendsViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 11.01.2022.
//

import UIKit
import SwiftUI
import RealmSwift

class MyFriendsViewController: UIViewController {
    
    
    @IBOutlet weak var myFriendsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let service = ServiceVK()
    //let realm = RealmCacheService()
    
    let fromMyFriendsToGallery = "fromMyFriendsToGallery"
    
    
    private var token: NotificationToken?
    let dataLoader = LoadDataFromRealmAdapter()
    
    var sourceFriends = [Friend]()
    var friendsForSearchBar = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brandPink
        
        myFriendsTableView.dataSource = self
        myFriendsTableView.delegate = self
        
        searchBar.delegate = self
        
        myFriendsTableView.register(UINib(nibName: "Universal  TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableViewCell)
        
        token = dataLoader.loadFriendsFromRealm(tableView: myFriendsTableView) { friends in
            self.sourceFriends = friends
            self.myFriendsTableView.reloadData()
        }
        
        service.loadPhotos()
    }
}

// MARK: - TableViewDelegate

extension MyFriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromMyFriendsToGallery,
           let destinationController = segue.destination as? GalleryViewController,
           let friend = sender as? Friend {
            
            print("Загрузка фото для пользвателя с ид: \(friend.id)")
            
            dataLoader.loadPhotosFromRealm(friend: friend) { photos in
                destinationController.fotoArray = photos
            }
            
            if destinationController.fotoArray.isEmpty {
                let reservedPhoto = Photo(ownerID: friend.id,
                                          url: "https://sun9-21.userapi.com/c10956/u18286/-7/w_45ece801.jpg",
                                          likesCount: 0)
                destinationController.fotoArray.append(reservedPhoto)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


//MARK: - TableViewDataSource

extension MyFriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceFriends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myFriendsTableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalTableViewCell, for: indexPath) as? Universal__TableViewCell
        else {return UITableViewCell()}
    
        cell.configure(friend: sourceFriends[indexPath.row], completion: {[weak self] in
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.fromMyFriendsToGallery, sender: self.sourceFriends[indexPath.row])
        })
        return cell
    }
}

//MARK: - SearchBarDelegate

extension MyFriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            friendsForSearchBar = sourceFriends
        } else {
            friendsForSearchBar = sourceFriends.filter({sourceFriendsItem in
                sourceFriendsItem.firstName.lowercased().contains(searchText.lowercased()) || sourceFriendsItem.lastName.lowercased().contains(searchText.lowercased())
            })
        }
        myFriendsTableView.reloadData()
    }
}

/*
private extension MyFriendsViewController{
    
    
    func createNotificationToken() {
        
        self.token = friendsFromRealm?.observe { [weak self] results in
            guard let self = self else { return }
            
            switch results {
            case .initial(_):
                print("Token for friends controller initialized")
                
            case .update(let friendsData,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                
                print("We have \(friendsData.count) friends")
                
                let deletionsIndexPath = deletions.map { IndexPath (row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0)}
                
                self.myFriendsTableView.beginUpdates()
                self.myFriendsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                self.myFriendsTableView.insertRows(at: insertionsIndexPath, with: .automatic)
                self.myFriendsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                self.myFriendsTableView.endUpdates()
                self.loadMyFriendsFromRealm()
                
            case .error(let error):
                print("\(error)")
            }
        }
    }
  
}
*/
