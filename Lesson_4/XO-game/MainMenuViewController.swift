//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Екатерина Алексеева on 04.07.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var enemySegmentedControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameViewController" {
                    if enemySegmentedControl.selectedSegmentIndex == 0 {
                        GameSettings.shared.isEnemyComputer = false
                    }
                    else if enemySegmentedControl.selectedSegmentIndex == 1 {
                        GameSettings.shared.isEnemyComputer = true
                    }
        }
    }
    
   @IBAction func startButtonPressed(_ sender: Any) {
    }
}
