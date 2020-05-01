//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isFinishedTypingNuber = true
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNuber = true
        let number = Double(displayLabel.text!)!
        if let calcMethod = sender.currentTitle {
            if calcMethod == "AC" {
                displayLabel.text = String(0)
            }
            else if calcMethod == "+/-" {
                displayLabel.text = String(number * -1)
            } else if calcMethod == "%" {
                displayLabel.text = String(number * 0.01)
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numberValue = sender.currentTitle {
            if isFinishedTypingNuber {
                displayLabel.text = numberValue
                isFinishedTypingNuber = false
            } else {
                displayLabel.text = displayLabel.text! + numberValue
            }
        }
    }
}
