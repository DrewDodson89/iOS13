//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // IBOutlets
    @IBOutlet var diceImageView1: UIImageView!
    @IBOutlet var diceImageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diceImageView1.image = UIImage(named: "Dice1")
        diceImageView2.image = UIImage(named: "Dice2")
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let diceOne = Int.random(in: 1...6)
        let diceTwo = Int.random(in: 1...6)
        updateUI(diceOne: diceOne, diceTwo: diceTwo)
    }
    
    func updateUI(diceOne: Int, diceTwo: Int) {
        
        diceImageView1.image = UIImage(named: "Dice\(diceOne)")
        diceImageView2.image = UIImage(named: "Dice\(diceTwo)")

    }
    



// FINAL } IN THE CLASS
}
