//
//  MyPageViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 11.01.2022.
//

import UIKit
import FirebaseAuth

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var homeCookerLabel: UILabel!
    @IBOutlet weak var inProfessionLabel: UILabel!
    @IBOutlet weak var sinceBornLabel: UILabel!
    
    @IBOutlet weak var firstPurpleView: UIView!
    @IBOutlet weak var secondPurpleView: UIView!
    @IBOutlet weak var thirdPurpleView: UIView!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    private let service = ServiceVK()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brandPink
        logOutButton.backgroundColor = UIColor.brandPink
        
        avatarImage.layer.cornerRadius = avatarView.layer.cornerRadius
        avatarView.layer.opacity = 0.5
        nameLabel.layer.opacity = 0.5
        homeCookerLabel.layer.opacity = 0.5
        inProfessionLabel.layer.opacity = 0.5
        sinceBornLabel.layer.opacity = 0.5
        
        service.loadData(method: .friendsGet)
        service.loadData(method: .myGroupsGet)
        
        animatePurplePoints(totalCount: 2)
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch (let error) {
            print("Auth sign out failed: \(error)") }
    }
    
    func animatePurplePoints(totalCount: Int, currentCount: Int = 0) {
        
        if currentCount < totalCount {
        
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.firstPurpleView.alpha = 1
            self?.secondPurpleView.alpha = 0
            self?.thirdPurpleView.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {[weak self] in
                self?.firstPurpleView.alpha = 0.5
                self?.secondPurpleView.alpha = 1
                self?.thirdPurpleView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {[weak self] in
                    self?.firstPurpleView.alpha = 0
                    self?.secondPurpleView.alpha = 0.5
                    self?.thirdPurpleView.alpha = 1
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {[weak self] in
                        self?.firstPurpleView.alpha = 0
                        self?.secondPurpleView.alpha = 0
                        self?.thirdPurpleView.alpha = 0.5
                    }
                completion: { [weak self] _ in
                    self?.animatePurplePoints(totalCount: totalCount, currentCount: currentCount + 1)
                }
                }
            }
        }
        } else {
            firstPurpleView.alpha = 0
            secondPurpleView.alpha = 0
            thirdPurpleView.alpha = 0
            
            avatarView.layer.opacity = 1
            nameLabel.layer.opacity = 1
            homeCookerLabel.layer.opacity = 1
            inProfessionLabel.layer.opacity = 1
            sinceBornLabel.layer.opacity = 1
        }
    }
}

