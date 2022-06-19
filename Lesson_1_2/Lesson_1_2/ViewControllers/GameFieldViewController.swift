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
    
    var questions = [Question]()
    var numberOfQuestion = 0
    weak var gameSessionDelegate: GameSessionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareQuestionField()
        prepareAnswersButtons()
    }
    
    @IBAction func buttonWithAnswerPressed(_ sender: Any) {
        let button = sender as? UIButton
        let selectedAnswer = button?.titleLabel?.text
        let trueAnswer = questions[numberOfQuestion].trueAnswer
        if selectedAnswer == trueAnswer {
            if numberOfQuestion < questions.count - 1 {
                numberOfQuestion += 1
                self.viewDidLoad()
            }
        } else {
            gameSessionDelegate?.didEndGame(withResult: numberOfQuestion)
            self.dismiss(animated: true)
        }
    }
    
    //Загружаем текст вопроса
    func prepareQuestionField() -> Void {
        questionTextView.text = questions[numberOfQuestion].question
    }

    //Загружаем тексты ответов, предварительно перемешав их
    func prepareAnswersButtons() -> Void {
        var answers = [String]()
        answers.append(questions[numberOfQuestion].trueAnswer)
        answers.append(questions[numberOfQuestion].falseAnswerFirst)
        answers.append(questions[numberOfQuestion].falseAnswerSecond)
        answers.append(questions[numberOfQuestion].falseAnswerThird)
        answers.shuffle()
        
        answerFirstButton.setTitle(answers[0], for: .normal)
        answerSecondButton.setTitle(answers[1], for: .normal)
        answerThirdButton.setTitle(answers[2], for: .normal)
        answerFourthButton.setTitle(answers[3], for: .normal)
    }
    
    //Формируем вопросы (функция вызывается в MainViewController при формировании сеги)
    func loadQuestions() -> [Question] {
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
        return questions
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

