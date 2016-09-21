//
//  RecorderViewController.swift
//  whatever
//
//  Created by Patrice Müller on 14.09.16.
//  Copyright © 2016 Patrice Müller. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController:UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordinButton: UIButton!
    
    let recordingString = "Recording"
    let recordingLabelString = "Tap To Record"
    
    var audioRecorder: AVAudioRecorder!
    
    var isRecordingState = false
    var isRecording : Bool {
        set {
            isRecordingState = newValue
            updateButtonState()
            updateText()
        }
        get { return isRecordingState }
    }
    
    func startRecording(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let recordingName = "/recordVoice.wav"
        let path = dirPath+recordingName
        let filePath = URL(fileURLWithPath: path)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func stopRecordingAudioFile(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isRecording = false
    }
    
    func updateButtonState(){
        recordingButton.isEnabled = !isRecording
        stopRecordinButton.isEnabled = isRecording
    }
    
    func updateText(){
        if isRecording {
            recordingLabel.text = recordingString
        }else{
            recordingLabel.text = recordingLabelString
        }
    }
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        print("Record Button was pressed")
        isRecording = true
        startRecording()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("Stop Record Button was pressed")
        isRecording = false
        stopRecordingAudioFile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else {
            print ("Saving the recording failed")
        }
    }
}

