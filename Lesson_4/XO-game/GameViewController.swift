//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
            if currentState is ComputerInputState  {
                let computerInputState = currentState as? ComputerInputState
                DispatchQueue.main.async {
                    //Запускаем sleep(1), чтобы увидеть настройки в состоянии ComputerInputState
                    sleep(1)
                    computerInputState?.createPosition()
                    self.goToNextState()
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        if self.currentState is PlayerInputState {
            gameboardView.onSelectPosition = { [weak self] position in
                guard let self = self else { return }
                self.currentState.addMark(at: position)
                if self.currentState.isCompleted {
                    self.goToNextState()
                }
            }
        }
        
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboard.clear()
        gameboardView.clear()
        self.viewDidLoad()
    }
    
    @IBAction func toMainMenuButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Private functions
    
    private func goToFirstState() {
        self.currentState = PlayerInputState(player: .first,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }
    
    private func goToNextState() {
        //Проверяем, не сложилась ли выигрышная ситуация
        if let winner = self.referee.determineWinner() {
            self.currentState = GameFinishedState(winner: winner, gameViewController: self)
            return
        }
        //Проверяем, кто ходил в текущем ходе: компьютер или игрок
        //Последний ход сделал компьютер
        if currentState is ComputerInputState {
            self.currentState = PlayerInputState(player: .first,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
        }
        
        //Последний ход сделал один из игроков
        else {
            if let playerInputState = currentState as? PlayerInputState {
                if GameSettings.shared.isEnemyComputer {
                    //Игра ведется против компьютера включаем состояние ComputerInputState, передем ход компьютеру
                    self.currentState = ComputerInputState(gameViewController: self,
                                                           gameboard: gameboard,
                                                           gameboardView: gameboardView)
                    
                } else  {
                    //Игра ведется двумя игроками, передаем ход следующему игроку
                    self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                         gameViewController: self,
                                                         gameboard: gameboard,
                                                         gameboardView: gameboardView)
                }
            }
        }
    }
}
