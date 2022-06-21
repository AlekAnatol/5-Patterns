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
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    private let resultCaretaker = ResultCaretaker()
    private var selectedDifficulty: Difficulty {
        switch difficultySegmentedControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .hard
        default:
            return .easy
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let lastScore = resultCaretaker.retrieveLastScore() else {
            lastResultLabel.text = "Послений результат: -"
            return
        }
        lastResultLabel.text = "Послений результат: \(lastScore)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Отрабатываем нажатие кнопки "Начать игру"
        if segue.identifier == "startGame" {
            //Загружаем массив вопросов в GameFieldViewController
            guard let gameFieldViewController = segue.destination as? GameFieldViewController else { return }
            Game.shared.loadQuestions()
            
            // Создаем объект класса GameSession и передаем его в синглтон
            let gameSession = GameSession(totalCountOfQuestions: Game.shared.questions.count,                                           correctlyAnsweredQuestions: gameFieldViewController.numberOfQuestion.value)
            gameSession.saveSessionInSingletone()
            
            gameFieldViewController.gameSessionDelegate = self
            gameFieldViewController.difficulty = selectedDifficulty
            gameFieldViewController.questions = gameFieldViewController.createQuestionstrategy.createQuestions()
            
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
    func didEndGame(withResult result: GameSession) {
        lastResultLabel.text = "Послений результат: \(result.correctlyAnsweredQuestions)"
        Game.shared.saveResult(gameSession: result)
    }
}
