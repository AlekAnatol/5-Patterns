//
//  Singletone.swift
//  XO-game
//
//  Created by Екатерина Алексеева on 04.07.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class GameSettings {
    static var shared = GameSettings()
    var isEnemyComputer = Bool()
    
    private init() { }
}
