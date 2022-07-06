//
//  Singletone Game.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 20.06.2022.
//

import Foundation

//MARK: - Синглтон для хранения данных по очкам
final class Game {
    static var shared = Game()
    var gameSession: GameSession?
    var questions = [Question]()

    private let resultCaretaker = ResultCaretaker()
    
    private (set) var gameResults: [Result] {
        didSet {
            resultCaretaker.saveResults(results: self.gameResults)
        }
    }
    
    private init() {
        self.gameResults = resultCaretaker.retrieveAllResults()
    }
    
    func saveResult(gameSession: GameSession) {
        let date = Date()
        let result = Result(countOfAnswers: gameSession.correctlyAnsweredQuestions,
                            percentOfAnswers: gameSession.percent,
                            date: date)
        Game.shared.addResult(result: result)
    }
    
    private func addResult(result: Result) {
        Game.shared.gameResults.append(result)
    }
    
    func loadQuestions() {
        var questions = [Question]()
        
        let question1 = Question(question: "Кто приходит под Новый год к хорошим детям?",
                                 trueAnswer: "Дед Мороз",
                                 falseAnswerFirst: "Баба-Яга",
                                 falseAnswerSecond: "Милиционер",
                                 falseAnswerThird: "Директор школы")
        questions.append(question1)
        
        let question2 = Question(question: "Чем едят суп?",
                                 trueAnswer: "Ложками",
                                 falseAnswerFirst: "Вилками",
                                 falseAnswerSecond: "Руками",
                                 falseAnswerThird: "Совочками")
        questions.append(question2)
        
        let question3 = Question(question: "Что растет на дубе",
                                 trueAnswer: "Желуди",
                                 falseAnswerFirst: "Шишки",
                                 falseAnswerSecond: "Яблоки",
                                 falseAnswerThird: "Золотая цепь")
        questions.append(question3)
       
        let question4 = Question(question: "Во что превращается вода на морозе?",
                                 trueAnswer: "В лед",
                                 falseAnswerFirst: "В пар",
                                 falseAnswerSecond: "В газ",
                                 falseAnswerThird: "В кисель")
        questions.append(question4)
        
        let question5 = Question(question: "В какой рисунок разрисована зебра?",
                                 trueAnswer: "В полосочку",
                                 falseAnswerFirst: "В горошек",
                                 falseAnswerSecond: "В цветочек",
                                 falseAnswerThird: "В клеточку")
        questions.append(question5)
        self.questions = questions
    }
}

/// Qiestions
/*
 6. Где не бывает рыбы?

 В реке.
 В озере.
 В ухе.
 В компоте.

 7. На что похожа стрекоза?

 На телевизор.
 На эскалатор.
 На вертолет.
 На кухонный комбайн.

 8. На чем летает Баба-Яга?

 На венике.
 На метле.
 На швабре.
 На пылесосе.

 9. Что чаще всего вешают на елку?

 Шарики.
 Кубики.
 Тюбики.
 Зубики.

 10. Чем мажут царапины?

 Зеленкой.
 Красненкой.
 Белилкой.
 Чернилкой. */


