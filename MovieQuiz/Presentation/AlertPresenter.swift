//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Maxim Volkov on 03.11.2024.
//

import UIKit

class AlertPresenter: AlertPresenterProtocol {
    weak var viewController: UIViewController?
    
    func showAlert(with model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        let action = UIAlertAction(title: model.buttonText, style: .default, handler: { _ in model.completion() } )
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
