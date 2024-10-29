import UIKit

// Структура данных вопроса
struct QuizQuestion {
    let image: String
    let text: String
    let correctAnswer: Bool
}

// Структура данных для внешенего вида вопроса
struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}

// Результат квиза
struct QuizResultsViewModel {
    let title: String
    let text: String
    let buttonText: String
}

final class MovieQuizViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    
    private let questions: [QuizQuestion] = [
    QuizQuestion(image: "The Godfather", 
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: true),
    QuizQuestion(image: "The Dark Knight", 
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: true),
    QuizQuestion(image: "Kill Bill", 
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: true),
    QuizQuestion(image: "The Avengers", 
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: true),
    QuizQuestion(image: "Deadpool", 
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: true),
    QuizQuestion(image: "The Green Knight",
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: true),
    QuizQuestion(image: "Old",
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: false),
    QuizQuestion(image: "The Ice Age Adventures of Buck Wild",
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: false),
    QuizQuestion(image: "Tesla",
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: false),
    QuizQuestion(image: "Vivarium",
                 text: "Рейтинг этого фильма больше чем 6?",
                 correctAnswer: false)]
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentQuestion = questions[currentQuestionIndex]
        let currentQuestionViewModel = convert(model: currentQuestion)
        show(quiz: currentQuestionViewModel)
    }
    
    @IBAction private func yesButtonClick(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        showAnswerResult(isCorrect: currentQuestion.correctAnswer == true)
    }
    
    @IBAction private func noButtonClick(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        showAnswerResult(isCorrect: currentQuestion.correctAnswer == false)
    }
    
    // конвертация мока во view model
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }
    
    // вывод на экран вопроса
    private func show(quiz step: QuizStepViewModel) {
        // Сброс рамки после предыдущего вопроса
        // Из-за глюка на симуляторе 13 mini (после зеленой рамки
        // на следующем постере оставалась справа зеленая линия
        // толщиной в 1-2 точки) решил
        // использовать сразу два приравнивания
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.clear.cgColor
        
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    // покраска рамки
    private func showAnswerResult(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        if isCorrect {
            correctAnswers += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    
    // переход дальше
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            let resultText: String = "Ваш результат: " + String(correctAnswers) + "/10"
            let resultViewModel = QuizResultsViewModel(title: "Этот раунд окончен!", text: resultText, buttonText: "Сыграть ещё раз")
            show(quiz: resultViewModel)
            
        } else {
            currentQuestionIndex += 1
            
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            
            show(quiz: viewModel)
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(title: result.title, message: result.text, preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}



/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
