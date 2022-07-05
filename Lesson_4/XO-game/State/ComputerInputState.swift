//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Екатерина Алексеева on 04.07.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public class ComputerInputState: GameState {
    
    public private(set) var isCompleted = false
    public var player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(gameViewController: GameViewController,
        gameboard: Gameboard,
        gameboardView: GameboardView) {
            self.player = .computer
            self.gameViewController = gameViewController
            self.gameboard = gameboard
            self.gameboardView = gameboardView
        }
    
    public func begin() {
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.text = "Computer"
        self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView,
                  gameboardView.canPlaceMarkView(at: position) else {
            createPosition()
            return
        }
        let markView = OView()
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(markView, at: position)
        self.isCompleted = true
    }
    
    public func createPosition() {
        let random = Int.random(in: 0..<8)
        let column = random / GameboardSize.columns
        let row = random % GameboardSize.columns
        let position = GameboardPosition(column: column, row: row)
        self.addMark(at: position)
    }
}
    
