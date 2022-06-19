//
//  Questions.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 16.06.2022.
//

import Foundation

//MARK: - Структура для работы с вопросами викторины
struct Question {
    let question: String
    let trueAnswer: String
    let falseAnswerFirst: String
    let falseAnswerSecond: String
    let falseAnswerThird: String
}

//MARK: - Синглтон для хранения данных по очкам
final class Game {
    static var shared = Game()
    var gameSession: GameSession?

    private let resultCaretaker = ResultCaretaker()
    
    private (set) var gameResults: [Result] {
        didSet {
            resultCaretaker.saveResults(results: self.gameResults)
        }
    }
    
    private init() {
        self.gameResults = resultCaretaker.retrieveAllResults()
    }
    
    func calculationOfPercent(correctlyAnsweredQuestions: Int) {
        Game.shared.gameSession?.correctlyAnsweredQuestions = correctlyAnsweredQuestions
        if let totalCount = Game.shared.gameSession?.totalCountOfQuestions {
            let percent = (correctlyAnsweredQuestions * 100)/totalCount
            let date = Date()
            let result = Result(percentOfAnswers: percent, date: date)
            Game.shared.gameSession = GameSession(totalCountOfQuestions: 0, correctlyAnsweredQuestions: 0)
            Game.shared.addResult(result: result)
        }
    }
    
    private func addResult(result: Result) {
        Game.shared.gameResults.append(result)
    }
}

//MARK: - Класс для хранения данных по текущей игре
final class GameSession {
    let totalCountOfQuestions: Int
    var correctlyAnsweredQuestions: Int
    
    init(totalCountOfQuestions: Int, correctlyAnsweredQuestions: Int) {
        self.totalCountOfQuestions = totalCountOfQuestions
        self.correctlyAnsweredQuestions = correctlyAnsweredQuestions
    }
}

//MARK: - Делегат для передачи количества очков в текущей игре
protocol GameSessionDelegate: AnyObject {
    func didEndGame(withResult result: Int)
}

//MARK: - Структура для хранения информации по текущей игре
struct Result: Codable {
    let percentOfAnswers: Int
    let date: Date
}


//MARK: - Класс для реализации Мементо
final class ResultCaretaker {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let key = "results"
    
    func saveResults(results: [Result]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
            print("error in encoder")
        }
    }
    
    func retrieveAllResults() -> [Result] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            let results = try decoder.decode([Result].self, from: data)
            return results
        }
        catch {
            print("error in decoder")
            return []
        }
    }
    
    func retrieveLastScore() -> Int {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return 0
        }
        do {
            let results = try decoder.decode([Result].self, from: data)
            return results.last?.percentOfAnswers ?? 0
        }
        catch {
            return 0
        }
    }
}
