//
//  Questions.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 16.06.2022.
//

import Foundation

//MARK: - Делегат для передачи количества очков в текущей игре
protocol GameSessionDelegate: AnyObject {
    func didEndGame(withResult result: GameSession)
}
