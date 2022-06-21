//
//  CreateQuestionsStrategy.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 21.06.2022.
//

import Foundation

protocol CreateQuestionsStrategy {
    func createQuestions() -> [Question]
}

final class SequentialCreateQuestions: CreateQuestionsStrategy {
    func createQuestions() -> [Question] {
        return Game.shared.questions
    }
}

final class RandomCreateQuestions: CreateQuestionsStrategy {
    func createQuestions() -> [Question] {
        var questions = Game.shared.questions
        questions.shuffle()
        return questions
    }
}
