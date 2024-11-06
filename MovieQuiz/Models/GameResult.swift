//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Maxim Volkov on 05.11.2024.
//

import Foundation

struct GameResult {
    var correct: Int
    var total: Int
    var date: Date
    
    func isBetter(than result: GameResult) -> Bool {
        correct > result.correct
    }
}
