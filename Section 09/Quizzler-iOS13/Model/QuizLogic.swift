//
//  QuizLogic.swift
//  Quizzler-iOS13
//
//  Created by Drew Dodson on 3/16/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation


struct QuizLogic {
    
    var currentQuestion = 0
    
    var quiz = [
        Question(questionText: "A slug's blood is green.", questionAnswer: "True"),
        Question(questionText: "Approximately one quarter of human bones are in the feet.", questionAnswer: "True"),
        Question(questionText: "The total surface area of two human lungs is approximately 70 square metres.", questionAnswer: "True"),
        Question(questionText: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", questionAnswer: "True"),
        Question(questionText: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", questionAnswer: "False"),
        Question(questionText: "It is illegal to pee in the Ocean in Portugal.", questionAnswer: "True"),
        Question(questionText: "You can lead a cow down stairs but not up stairs.", questionAnswer: "False"),
        Question(questionText: "Google was originally called 'Backrub'.", questionAnswer: "True"),
        Question(questionText: "Buzz Aldrin's mother's maiden name was 'Moon'.", questionAnswer: "True"),
        Question(questionText: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", questionAnswer: "False"),
        Question(questionText: "No piece of square dry paper can be folded in half more than 7 times.", questionAnswer: "False"),
        Question(questionText: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", questionAnswer: "True")
    ]
    
    func checkAnswer(_ chosenAnswer: String) -> Bool{
        let currentAnswer = quiz[currentQuestion].questionAnswer
        if chosenAnswer == currentAnswer {
            return true
        } else {
            return false
        }
    }
    
    
    
    mutating func startGame() {
        currentQuestion = 0
        quiz.shuffle()
    }
    
    
    mutating func checkGameState() {
                if currentQuestion + 1 < quiz.count {
                    currentQuestion += 1
                } else {
                    currentQuestion = 0
                    quiz.shuffle()
                }
    }
    
    
    
    func getQuestionText() -> String{
        return quiz[currentQuestion].questionText
    }
    
    
    
    func getProgress() -> Float{
        return Float(currentQuestion + 1) / Float(quiz.count)
    }
    
}
