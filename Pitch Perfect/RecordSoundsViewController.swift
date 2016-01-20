//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Stanley Pan on 1/20/16.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
    }

    // Method for recording the user's voice
    // IBAction linked to button with a microphone icon
    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        stopButton.hidden = false
        recordingInProgress.hidden = false
        // Get path to DocumentDirectory within our app
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        // Setup audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        // Initialize and prepare the recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // Method for saving recorded audio data, and passing it when performing segue
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url  //reference to audio file actually recorded on phone
            recordedAudio.title = recorder.url.lastPathComponent  //gives us name of recorded file
            //TODO: Move to next scene by performing segue
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else {
            print("Recording was not successful.")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    // Method for ending the user's voice recording
    // IBAction linked to button with a stop icon
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        // Stop the audio recorder and deactivate the audio session
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
}

