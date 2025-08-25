////
////  QuizView.swift
////  Focus AI
////
////  Created by Ogabek Bakhodirov on 23/02/25.
////
//
//import UIKit
////
//
//class QuizView: UIView {
//    
//    // UI Elements
//    private let questionLabel = UILabel()
//    private let answerButtons: [UIButton] = (0..<4).map { _ in UIButton(type: .system) }
//    private let progressLabel = UILabel()
//    
//    var questions: [QuestionWrapper] = [] {
//            didSet {
//                updateQuizView()
//            }
//        }
//    
//    private var currentQuestionIndex = 0
//    private var score = 0
//    
//    func setupQuestionLabel(){
//        questionLabel.textAlignment = .center
//        questionLabel.translatesAutoresizingMaskIntoConstraints = false
//        questionLabel.textColor = .colorBlack
//        questionLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        questionLabel.numberOfLines = 0
//        questionLabel.heightAnchor.constraint(equalToConstant: universalHeight(160)).isActive = true
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.backgroundColor = .clear
//        setupUI()
//    }
//    
//    private func setupUI() {
//        loadQuestion()
//        // Configure Question Label
//        setupQuestionLabel()
//        
//        // Configure Answer Buttons
//        for (index, button) in answerButtons.enumerated() {
//            button.tag = index
//            button.setTitleColor(.colorWhite, for: .normal)
//            button.backgroundColor = .colorBlack
//            button.layer.cornerRadius = 10
//            button.heightAnchor.constraint(equalToConstant: 55).isActive = true // Increased height
//            button.addTarget(self, action: #selector(answerSelected(_:)), for: .touchUpInside)
//        }
//        
//        // Configure Progress Label
//        progressLabel.textAlignment = .center
//        progressLabel.textColor = .colorBlack
//        progressLabel.font = UIFont.systemFont(ofSize: 18)
//        
//        // Stack Views for Layout
//        let stackView = UIStackView(arrangedSubviews: answerButtons)
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
//        
//        addSubview(questionLabel)
//        addSubview(stackView)
//        addSubview(progressLabel)
//        
//        
//        // Constraints
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        progressLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        NSLayoutConstraint.activate([
//            questionLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: universalHeight(100)),
//            questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
//            questionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
//            questionLabel.heightAnchor.constraint(equalToConstant: universalHeight(160)),
//            
//            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
//            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            stackView.heightAnchor.constraint(equalToConstant: universalHeight(280)),
//            
//            progressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
//            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
//    }
//    
//    func updateQuizView(){
//        self.subviews.forEach { $0.removeFromSuperview() }
//        setNeedsLayout()
//        layoutIfNeeded()
//        
//        setupUI()
//    }
//    
//    private func loadQuestion() {
//        progressLabel.text = "Score: \(score)" //\(currentQuestionIndex + 1) of \(questions.count)
//        guard currentQuestionIndex < questions.count else {
//            showFinalScore()
//            return
//        }
//        
//        let currentQuestion = questions[currentQuestionIndex].question
//        questionLabel.text = currentQuestion.text
//        for (index, button) in answerButtons.enumerated() {
//            button.setTitle(currentQuestion.answers[index], for: .normal)
//            button.isHidden = false
//        }
//        
//
//    }
//    
//    @objc private func answerSelected(_ sender: UIButton) {
//        let selectedAnswerIndex = sender.tag
//        let correctAnswerIndex = questions[currentQuestionIndex].question.correctAnswerIndex
//        
//        if selectedAnswerIndex == correctAnswerIndex {
//            sender.backgroundColor = #colorLiteral(red: 0, green: 0.3600063324, blue: 0, alpha: 1)
//            score += 1
//            UserModel.shared.addPoints()
//        } else {
//            sender.backgroundColor = .red
//        }
//        UserModel.shared.updateQuizHistory(quiz: ["\(questions[currentQuestionIndex].question)", "userAnswer : \(selectedAnswerIndex)"])
//        //Task add question and users answer to UserModel history
//        currentQuestionIndex += 1
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//            sender.backgroundColor = .colorBlack
//            self.loadQuestion()
//        }
//    }
//    
//    private func showFinalScore() {
//        questionLabel.text = "Quiz Completed! Your Score: \(score) / \(questions.count)"
//        
//        for button in answerButtons {
//            button.isHidden = true
//        }
//    }
//}
//
//
//struct Question {
//    let text: String
//    let answers: [String]
//    let correctAnswerIndex: Int
//}
//
////let questionsForEnglish: [Question] = [
////        Question(text: "Which word means 'not real'?", answers: ["Genuine", "Fake", "Kind", "Reliable"], correctAnswerIndex: 1),
////        Question(text: "What is the opposite of 'difficult'?", answers: ["Easy", "Hard", "Strong", "Fast"], correctAnswerIndex: 0),
////        Question(text: "Which word describes someone who helps others?", answers: ["Selfish", "Kind", "Lazy", "Angry"], correctAnswerIndex: 1),
////        Question(text: "Which word means 'to make something better'?", answers: ["Destroy", "Improve", "Ignore", "Forget"], correctAnswerIndex: 1),
////        Question(text: "Which word means 'very big'?", answers: ["Tiny", "Huge", "Narrow", "Short"], correctAnswerIndex: 1)
////]
