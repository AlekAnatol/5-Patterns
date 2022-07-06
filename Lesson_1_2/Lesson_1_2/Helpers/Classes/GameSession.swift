//
//  GameSession.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 20.06.2022.
//

import Foundation

//MARK: - Класс для хранения данных по текущей игре
final class GameSession {
    let totalCountOfQuestions: Int
    var correctlyAnsweredQuestions: Int
    var percent: Int {
        return ((correctlyAnsweredQuestions * 100)/totalCountOfQuestions)
    }
    
    init(totalCountOfQuestions: Int, correctlyAnsweredQuestions: Int) {
        self.totalCountOfQuestions = totalCountOfQuestions
        self.correctlyAnsweredQuestions = correctlyAnsweredQuestions
    }
    
    func increaseСorrectlyAnsweredQuestions() {
        self.correctlyAnsweredQuestions += 1
        //self.percent = (correctlyAnsweredQuestions * 100)/totalCountOfQuestions
    }
    
    func saveSessionInSingletone() {
        Game.shared.gameSession = self
    }
}
