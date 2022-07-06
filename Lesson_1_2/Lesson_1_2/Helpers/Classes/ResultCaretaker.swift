//
//  ResultCaretaker.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 20.06.2022.
//

import Foundation

//MARK: - Класс для реализации Мементо
final class ResultCaretaker {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let key = "results"
    
    //Функция для сохранения данных
    func saveResults(results: [Result]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
            print("error in encoder")
        }
    }
    
    //Функция, возвращающая все сохраненные результаты игры
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
    
    //Функция, возвращающая количстве правильных ответов в послдней сохраненной игре
    func retrieveLastScore() -> Int? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            let results = try decoder.decode([Result].self, from: data)
            return results.last?.countOfAnswers ?? 0
        }
        catch {
            return 0
        }
    }
}
