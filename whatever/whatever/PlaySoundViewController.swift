//
//  PlaySoundViewController.swift
//  whatever
//
//  Created by Patrice Müller on 16.09.16.
//  Copyright © 2016 Patrice Müller. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunktButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case slow = 0, fast, chipunk, vader, echo, reverb }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton){
        print("Play Sond Button Pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(0.5)
        case .fast:
            playSound(1.5)
        case .chipunk:
            playSound(pitch: 1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        default: playSound()
        }
        
        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton){
        print("Stop Audio Button pressed")
        stopAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
