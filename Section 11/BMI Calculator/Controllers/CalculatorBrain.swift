//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Drew Dodson on 3/20/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {

    
    var bmi: BMI?



    func getBMIValue() -> String {
        let formattedBMIValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return formattedBMIValue
    }



    func getAdvice() -> String{
        return bmi?.advice ?? "No advice"
    }



    func getColor() -> UIColor{
        return bmi?.color ?? UIColor.white
    }



    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
             bmi = BMI(value: bmiValue, advice: "You are underweight!", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        } else if bmiValue < 24.9 {
             bmi = BMI(value: bmiValue, advice: "You are a normal weight", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        } else {
             bmi = BMI(value: bmiValue, advice: "You are overwight", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
    }



    
    
}
