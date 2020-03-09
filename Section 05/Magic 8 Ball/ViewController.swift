//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    
    let ballArray = [#imageLiteral(resourceName: "ball4"),#imageLiteral(resourceName: "ball2"),#imageLiteral(resourceName: "ball2"),#imageLiteral(resourceName: "ball2"),#imageLiteral(resourceName: "ball5")]

    @IBAction func askButtonPressed(_ sender: UIButton) {
        updateUI(ballNumber: Int.random(in: 0..<ballArray.count))
    }
    
    func updateUI(ballNumber: Int) {
        imageView.image = ballArray[ballNumber]
    }





// FINAL } IN THE CLASS ViewController
}
