//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Maxim Volkov on 03.11.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    
    var completion: (() -> Void)
}
