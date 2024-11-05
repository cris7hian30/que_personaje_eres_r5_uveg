//
//  ViewController.swift
//  quePersonajeEres
//
//  Created by Cristhian Jesus Valadez Sanchez on 04/11/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questions: [Question] = []
    var selectedAnswers: [Int] = []
    var currentQuestionIndex = 0
    var totalScore = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = [
            Question(text: "Pregunta 1", options: ["Opción 1", "Opción 2", "Opción 3"], points: [10, 5, 0]),
            Question(text: "Pregunta 2", options: ["Opción 1", "Opción 2", "Opción 3"], points: [0, 10, 5]),
            Question(text: "Pregunta 3", options: ["Opción 1", "Opción 2", "Opción 3"], points: [5, 0, 10]),
            Question(text: "Pregunta 4", options: ["Opción 1", "Opción 2", "Opción 3"], points: [10, 0, 5]),
            Question(text: "Pregunta 5", options: ["Opción 1", "Opción 2", "Opción 3"], points: [5, 10, 0])
        ]
        
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        showQuestion()
    }
    
    func showQuestion() {
        if currentQuestionIndex < questions.count {
            let currentQuestion = questions[currentQuestionIndex]
            questionLabel.text = currentQuestion.text
            optionsTableView.reloadData()
        } else {
            displayResult()
        }
    }
    
    func displayResult() {
        var character = ""
        switch totalScore {
        case 0..<15:
            character = "Personaje A: descripción del personaje"
        case 15..<30:
            character = "Personaje B: descripción del personaje"
        default:
            character = "Personaje C: descripción del personaje"
        }
        
        resultLabel.text = character
        resultLabel.isHidden = false
        questionLabel.isHidden = true
        optionsTableView.isHidden = true
        nextButton.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = questions[currentQuestionIndex].options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let points = questions[currentQuestionIndex].points[indexPath.row]
        totalScore += points
        selectedAnswers.append(indexPath.row)
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            showQuestion()
        } else {
            displayResult()
        }
    }
}


