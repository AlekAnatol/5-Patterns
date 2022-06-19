//
//  MainMenuViewController.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 16.06.2022.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var lastResultLabel: UILabel!
    
    private let resultCaretaker = ResultCaretaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Отрабатываем нажатие кнопки "Начать игру"
        if segue.identifier == "startGame" {
            //Загружаем массив вопросов в GameFieldViewController
            guard let gameFieldViewController = segue.destination as? GameFieldViewController else { return }
            gameFieldViewController.questions = gameFieldViewController.loadQuestions()
            // Создаем объект класса GameSession и передаем его в синглтон
            let gameSession = GameSession(totalCountOfQuestions: gameFieldViewController.questions.count,                                correctlyAnsweredQuestions: gameFieldViewController.numberOfQuestion)
            gameFieldViewController.gameSessionDelegate = self
            Game.shared.gameSession = gameSession
        }
        
        //Отрабатываем нажатие кнопки "Результаты"
        if segue.identifier == "toResultsTableView" {
            guard let resultsViewController = segue.destination as? ResultsViewController else { return }
            resultsViewController.results = resultCaretaker.retrieveAllResults()
        }
    }
}

//Реализуем протокол GameSessionDelegate
extension MainMenuViewController: GameSessionDelegate {
    func didEndGame(withResult result: Int) {
        lastResultLabel.text = "Послений результат: \(result)"
        Game.shared.calculationOfPercent(correctlyAnsweredQuestions: result)
    }
}
