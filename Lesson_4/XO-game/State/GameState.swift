//
//  GameState.swift
//  XO-game
//
//  Created by Екатерина Алексеева on 04.07.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    //var player: Player { get }
    var isCompleted: Bool { get }
    func begin()
    func addMark(at position: GameboardPosition)
}
