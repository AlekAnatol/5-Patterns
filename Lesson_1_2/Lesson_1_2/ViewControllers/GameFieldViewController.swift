//
//  GameFieldViewController.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 16.06.2022.
//

import UIKit

class GameFieldViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerFirstButton: UIButton!
    @IBOutlet weak var answerSecondButton: UIButton!
    @IBOutlet weak var answerThirdButton: UIButton!
    @IBOutlet weak var answerFourthButton: UIButton!
    @IBOutlet weak var numberOfQestionLabel: UILabel!
    
    var questions = [Question]()
    var numberOfQuestion = Observable<Int>(0)
    var difficulty: Difficulty = .easy
    var gameSession: GameSession?
    
    var createQuestionstrategy: CreateQuestionsStrategy {
        switch difficulty {
        case .easy:
            return SequentialCreateQuestions()
        case .hard:
            return RandomCreateQuestions()
        }
    }
    
    weak var gameSessionDelegate: GameSessionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareQuestionField()
        prepareAnswersButtons()
        gameSession = GameSession(totalCountOfQuestions: questions.count,
                                  correctlyAnsweredQuestions: numberOfQuestion.value)
        
        // К свойству numberOfQuestion добавляем обсервер, чтобы при изменении его значения менялся текст лейбла numberOfQestionLabel
        numberOfQuestion.addObserver(self, removeIfExists: true, options: [.initial, .new]) {[weak self] (numberOfQuestion, _)  in
            guard let totalCountOfQuestions = self?.gameSession?.totalCountOfQuestions else {
                self?.numberOfQestionLabel.text = "Вопрос № 1 (0)%)"
                return
            }
            let percent = (numberOfQuestion * 100)/totalCountOfQuestions
            self?.gameSession?.increaseСorrectlyAnsweredQuestions()
            self?.gameSession?.saveSessionInSingletone()
            self?.numberOfQestionLabel.text = "Вопрос № \(numberOfQuestion + 1) (\(percent)%)"
        }
    }
    
    @IBAction func buttonWithAnswerPressed(_ sender: Any) {
        let button = sender as? UIButton
        let selectedAnswer = button?.titleLabel?.text
        let trueAnswer = questions[numberOfQuestion.value].trueAnswer
        guard let gameSession = self.gameSession  else { return }
        if selectedAnswer == trueAnswer {
            if numberOfQuestion.value < questions.count - 1 {
                numberOfQuestion.value += 1
                self.viewDidLoad()
            } else if numberOfQuestion.value == questions.count - 1 {
                numberOfQuestion.value += 1
                gameSessionDelegate?.didEndGame(withResult: gameSession)
                self.dismiss(animated: true)
            }
        }
             
        else {
            gameSessionDelegate?.didEndGame(withResult: gameSession)
            self.dismiss(animated: true)
        }
    }
    
    //Загружаем текст вопроса
    func prepareQuestionField() -> Void {
        questionTextView.text = questions[numberOfQuestion.value].question
    }

    //Загружаем тексты ответов, предварительно перемешав их
    func prepareAnswersButtons() -> Void {
        var answers = [String]()
        answers.append(questions[numberOfQuestion.value].trueAnswer)
        answers.append(questions[numberOfQuestion.value].falseAnswerFirst)
        answers.append(questions[numberOfQuestion.value].falseAnswerSecond)
        answers.append(questions[numberOfQuestion.value].falseAnswerThird)
        answers.shuffle()
        
        answerFirstButton.setTitle(answers[0], for: .normal)
        answerSecondButton.setTitle(answers[1], for: .normal)
        answerThirdButton.setTitle(answers[2], for: .normal)
        answerFourthButton.setTitle(answers[3], for: .normal)
    }
}
