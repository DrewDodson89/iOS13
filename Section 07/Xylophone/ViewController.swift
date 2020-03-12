//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func keyPressed(_ sender: UIButton) {
        playSound(senderTitle: sender.currentTitle!)
    }
    
    func playSound(senderTitle: String) {
        let url = Bundle.main.url(forResource: "\(senderTitle)", withExtension: "wav")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer?.play()
    }
//





// FINAL } IN THE CLASS
}
