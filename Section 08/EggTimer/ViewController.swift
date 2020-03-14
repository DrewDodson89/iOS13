//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var totalSeconds = 0
    var selectedHardness = 0
    var timer = Timer()
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTimer()
    }



    //Button was pressed for selected hardness
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        resetTimer()
        progressBar.isHidden = false
        let hardness = sender.currentTitle!
        selectedHardness = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        
    }



    //Update UI to show progress bar and detect when complete
    @objc func updateUI() {
        
        if totalSeconds == selectedHardness {
            timer.invalidate()
            progressBar.progress = 1.0
            topLabel.text = "Done"
            playAlarm()
        } else {
            print(totalSeconds)
            print(selectedHardness)
            let currentProgress: Float = Float(totalSeconds) / Float(selectedHardness)
            progressBar.progress = currentProgress
            totalSeconds += 1
        }
    }



    //Play completed alarm
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer?.play()
    }



    //Reset the timer to cook another egg
    func resetTimer() {
        timer.invalidate()
        progressBar.isHidden = true
        topLabel.text = "How do you like your eggs?"
        progressBar.progress = 0.0
        totalSeconds = 0
        selectedHardness = 0
    }



// FINAL } IN THE CLASS
}
