//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stanley Pan on 1/20/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Returns a String with the path of the folder where our mp3 is
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            // Converts String to NSURL
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            // init method for AVAudioPlayer
            audioPlayer = try! AVAudioPlayer(contentsOfURL: filePathUrl)
        }
        else {
            print("The filePath is empty.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method for playing the audio file slowly
    //IBAction linked to button with a snail icon
    @IBAction func playSlowAudio(sender: UIButton) {
        // Play audio slowly here
        audioPlayer.play()
    }
    
}
