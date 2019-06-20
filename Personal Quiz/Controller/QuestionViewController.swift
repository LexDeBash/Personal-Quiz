//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Alexey Efimov on 20/06/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var questionLable: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    // MARK: Pivate Properties
    private var questions = Question.getQuestions()
    private var questionIndex = 0 // Index of current question
    
    /// Answer choosen by user
    private var answersChoosen: [Answer] = []
    
}

// MARK: IBActions
extension QuestionViewController {
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnser = currentAnswers[currentIndex]
        answersChoosen.append(currentAnser)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChoosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswersButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChoosen.append(currentAnswers[index])
        
        nextQuestion()
    }
}

// MARK: UIViewController Methods
extension QuestionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update user interface
        updateUI()
    }
}

// MARK: User Interface
extension QuestionViewController {
    // Updates user interface
    private func updateUI() {
        // hide everything
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // get current question
        let currentQuestion = questions[questionIndex]
        questionLable.text = currentQuestion.text
        
        // get current answer
        let currentAnswers = currentQuestion.answers
        
        // calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)

        // set progress for questionProgressView
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // show stack view corresponding to question type
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
    }
    
    /// Setup single stack view
    ///
    /// - Parameter answers: [Answer] array with answers
    private func updateSingleStackView(using answers: [Answer]) {
        // show single satck view
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: [])
        }
    }
    
    /// Setup multiple stack view
    ///
    /// - Parameter answers: [Answer] array with answers
    private func updateMultipleStackView(using answers: [Answer]) {
        // show multiple satck view
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    /// Setup ranged stack view
    ///
    /// - Parameter answers: [Answer] array with answers
    private func updateRangedStackView(using answers: [Answer]) {
        // show ranged satck view
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
}

// MARK: - Navigation
extension QuestionViewController {
    // show next question or go to the next screen
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue" else { return }
        let resultsVC = segue.destination as! ResultsViewController
        resultsVC.responses = answersChoosen
    }
}
