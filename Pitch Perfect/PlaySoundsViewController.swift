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
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // init method for AVAudioPlayer
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true  // Need to set true to adjust playback rate
        
        audioEngine = AVAudioEngine()
        
        // Convert NSURL receivedAudio into AVAudioFile
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Method for playing the audio file slowly
    // IBAction linked to button with a snail icon
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableSpeed(0.5)
    }
    
    // Method for playing the audio file fast
    // IBAction linked to button with a rabbit icon
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableSpeed(2.0)
    }
    
    // Method for playing the audio file with different rate values
    func playAudioWithVariableSpeed(speed: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    // Method for playing the audio with chipmunk effect
    // IBAction linked to button with a chipmunk icon
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    // Method for playing the audio with darth vader effect
    // IBAction linked to button with a darth vader icon
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    // Method for playing the audio file with different pitch values
    func playAudioWithVariablePitch(pitch: Float){
        // Stop all audio before playback
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()  // Create audioNode
        audioEngine.attachNode(audioPlayerNode)  // Attach to audioEngine
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        // Connect audioNode to PitchEffect, and PitchEffect to output speaker
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()  // Start audio engine
        
        audioPlayerNode.play()
    }
    
    // Method for stopping audio playback
    // IBAction linked to button with a stop icon
    @IBAction func stopPlayback(sender: UIButton) {
        audioPlayer.stop()
    }
    
}
