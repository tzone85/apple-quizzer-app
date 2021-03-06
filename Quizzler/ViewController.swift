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
        
        nextQuestion()
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
        progressLabel.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
        
        //deviding the screen width with the number of questions we have in our questionbank
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count) * CGFloat(questionNumber + 1))
    }
    
    func nextQuestion() {
        if questionNumber < allQuestions.list.count{
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }else{
            let alert = UIAlertController(title: "Finished", message: "Ended, your score: \(score)", preferredStyle: .alert)
            
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
            ProgressHUD.showSuccess("Correct")
            score += 1
            
        }
        else {
            ProgressHUD.showError("Incorrect")
        }
    }
    
    func startOver() {
       questionNumber = 0
        score = 0
//        viewDidLoad()
        nextQuestion()
    }
}
