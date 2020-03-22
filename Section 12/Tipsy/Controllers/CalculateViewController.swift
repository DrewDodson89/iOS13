//
//  CalculateViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet var totalField: UITextField!
    @IBOutlet var zeroPercentButton: UIButton!
    @IBOutlet var tenPercentButton: UIButton!
    @IBOutlet var twentyPercentButton: UIButton!
    @IBOutlet var totalPersonsLabel: UILabel!
    
    var totalPersons = 2
    var totalBill = 0.0
    var tipToBeCalculated = 0.1
    var totalPerPerson = 0.0
    var formattedTotalPerPerson = ""
    var formattedTip = ""


    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    @IBAction func totalFieldEdited(_ sender: UITextField) {
        print(sender)
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        let subTotal = totalField.text!
        if subTotal != "" {
            totalBill = Double(subTotal)!
            let totalWithTip = (totalBill) * (1 + tipToBeCalculated)
            totalPerPerson = totalWithTip / Double(totalPersons)
            formattedTotalPerPerson = String(format: "%.2f", totalPerPerson)
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
        let destinationVC = segue.destination as! ResultsViewController
            destinationVC.formattedTotalPerPerson = formattedTotalPerPerson
            destinationVC.information = "Total bill split between \(totalPersons) with a \(tipToBeCalculated * 100)% tip."
        }
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        //Unselect all buttons
        zeroPercentButton.isSelected = false
        tenPercentButton.isSelected = false
        twentyPercentButton.isSelected = false
        
        //Select the current button
        sender.isSelected = true
        
        //Get the title and convert to a properly formatted double thne assign
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tipToBeCalculated = buttonTitleAsANumber / 100
    }



    @IBAction func totalPersonsChanged(_ sender: UIStepper) {
        totalPersons = Int(sender.value)
        totalPersonsLabel.text = String(totalPersons)
    }
    
}
