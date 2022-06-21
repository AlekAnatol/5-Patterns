//
//  Result.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 20.06.2022.
//

import Foundation

//MARK: - Структура для хранения информации по текущей игре
struct Result: Codable {
    let countOfAnswers: Int
    let percentOfAnswers: Int
    let date: Date
}
