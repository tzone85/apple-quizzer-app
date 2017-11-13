//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    
    //keeps track of the state.
    var questionNumber : Int = 0
    
    var score : Int = 0
    

    //Place your instance variables here
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
    }
    
    func nextQuestion() {
        if questionNumber < allQuestions.list.count{
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }else{
            let alert = UIAlertController(title: "Finished", message: "You're the bomb. Start over", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (alert) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer{
            score += 1
            print("You've got it!")
        }
        else {
            print("Wrong")
        }
    }
    
    func startOver() {
       questionNumber = 0
//        viewDidLoad()
        nextQuestion()
    }
}
