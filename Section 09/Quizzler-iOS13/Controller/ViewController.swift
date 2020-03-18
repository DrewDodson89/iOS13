//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var trueButton: UIButton!
    @IBOutlet var falseButton: UIButton!
    
    var quizLogic = QuizLogic()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
        updateUI()
    }



    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let selectedAnswer = sender.currentTitle!
        let userAnsweredCorrectly = quizLogic.checkAnswer(selectedAnswer)
        print(userAnsweredCorrectly)

       Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }



    @objc func updateUI() {
        questionLabel.text = quizLogic.getQuestionText()
        progressBar.progress = quizLogic.getProgress()
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        quizLogic.checkGameState()
    }



    func newGame() {
        quizLogic.startGame()
    }
//





//FINAL } IN THE CLASS
}
