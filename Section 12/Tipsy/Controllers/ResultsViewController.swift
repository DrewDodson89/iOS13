//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Drew Dodson on 3/21/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var totalPerPersonLabel: UILabel!
    @IBOutlet var informationLabel: UILabel!
    
    var formattedTotalPerPerson: String?
    var information: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        totalPerPersonLabel.text = formattedTotalPerPerson
        informationLabel.text = information
    }



    //Dismiss resultsView
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
