//
//  AddQuestionViewController.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 21.06.2022.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var trueAnswerTextView: UITextView!
    @IBOutlet weak var falseAnswerFirstTextView: UITextView!
    @IBOutlet weak var falseAnswerSecondTextView: UITextView!
    @IBOutlet weak var falseAnswerThirdTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc func addButtonPressed() {
        guard let question = questionTextView.text,
              let trueAnswer = trueAnswerTextView.text,
              let falseAnswerFirst = falseAnswerFirstTextView.text,
              let falseAnswerSecond = falseAnswerSecondTextView.text,
              let falseAnswerThird = falseAnswerThirdTextView.text else { return }
        let newQuestion = Question(question: question,
                                trueAnswer: trueAnswer,
                                falseAnswerFirst: falseAnswerFirst,
                                falseAnswerSecond: falseAnswerSecond,
                                falseAnswerThird: falseAnswerThird)
        Game.shared.questions.append(newQuestion)
        print(Game.shared.questions.count)
        self.dismiss(animated: true)
    }
}
                                     



