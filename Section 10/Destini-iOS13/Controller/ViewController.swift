//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        //YEET
    }



    @IBAction func choiceMade(_ sender: UIButton) {
        storyBrain.nextStory(userChoice: sender.tag)
        updateUI(updateTo: storyBrain.updateStateTo)
    }



    func updateUI(updateTo: Int) {
        storyLabel.text = storyBrain.storyArray[updateTo].title
        choice1Button.setTitle(storyBrain.storyArray[updateTo].choice1, for: .normal)
        choice2Button.setTitle(storyBrain.storyArray[updateTo].choice2, for: .normal)
    }



    func startGame() {
        updateUI(updateTo: 0)
    }
    




// FINAL } IN THE CLASS
}
