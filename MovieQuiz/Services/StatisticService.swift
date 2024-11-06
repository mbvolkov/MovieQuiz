//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Maxim Volkov on 05.11.2024.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard
    private enum Keys: String {
        case gamesCount
        case correct
        case total
        case date
        case correctAnswers
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            let result = GameResult(correct: correct, total: total, date: date)
            return result
        }
        set {
            storage.setValue(newValue.correct, forKey: Keys.correct.rawValue)
            storage.setValue(newValue.total, forKey: Keys.total.rawValue)
            storage.setValue(newValue.date, forKey: Keys.date.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        if gamesCount > 0 {
            return Double((correctAnswers * 100) / (10 * gamesCount))
        } else {
            return 0
        }
    }
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAnswers.rawValue)
        }
        set {
            storage.setValue(newValue, forKey: Keys.correctAnswers.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correctAnswers += count
        let gameResult = GameResult(correct: count, total: amount, date: Date())
        if gameResult.isBetter(than: bestGame) {
            bestGame = gameResult
        }
    }
}
