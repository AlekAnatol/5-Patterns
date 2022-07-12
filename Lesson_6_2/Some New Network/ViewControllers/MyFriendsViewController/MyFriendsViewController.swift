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
    
    private let service = ServiceVKProxy()
    let dataLoader = LoadDataFromRealmAdapter()
    
    let fromMyFriendsToGallery = "fromMyFriendsToGallery"
    
    var sourceFriends = [Friend]()
    var friendsForSearchBar = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brandPink
        myFriendsTableView.dataSource = self
        myFriendsTableView.delegate = self
        searchBar.delegate = self
        myFriendsTableView.register(UINib(nibName: "Universal  TableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalTableViewCell)
        
        dataLoader.loadFriendsFromRealm(tableView: myFriendsTableView) { friends in
            self.sourceFriends = friends
            self.myFriendsTableView.reloadData()
        }
        //Загружаем все фото всех друзей в реалм
        service.loadPhotos()
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
            DispatchQueue.main.async {
                self.dataLoader.loadPhotosFromRealm(friend: friend) { photos in
                    destinationController.fotoArray = photos
                }
            }
        }
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
