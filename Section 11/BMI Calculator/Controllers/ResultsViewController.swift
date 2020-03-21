//
//  ResultsViewController.swift
//  BMI Calculator
//
//  Created by Drew Dodson on 3/19/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?

    @IBOutlet var bmiValueLabel: UILabel!
    @IBOutlet var bmiStatementLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiValueLabel.text = bmiValue
        bmiStatementLabel.text = advice
        view.backgroundColor = color
        
    }



    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }





// FINAL } IN THE CLASS
}
