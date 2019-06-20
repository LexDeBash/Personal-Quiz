//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Alexey Efimov on 20/06/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: Public properties
    var responses: [Answer]!
    
    // MARK: IB Outlets
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel! 
}

// MARK: - UIViewController Methods
extension ResultsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateResult()
    }
}

// MARK: - Update UI
extension ResultsViewController {
    private func updateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = responses.map { $0.type }
        
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequencyAnimal)
    }
    
    private func updateUI(with animal: AnimalType) {
        resultAnswerLabel.text = "Вы - \(animal.rawValue)!"
        resultDefinitionLabel.text = "\(animal.definition)"
    }
}
