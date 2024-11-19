//
//  NetworkRoutingProtocol.swift
//  MovieQuiz
//
//  Created by Maxim Volkov on 17.11.2024.
//

import Foundation


protocol NetworkRoutingProtocol {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}
