//
//  PlaySoundsViewController.swift
//  pitchGang
//
//  Created by Jameka Echols on 2/15/21.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioRecordURL : URL!
    @IBOutlet weak var chipmuckButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case chipmunk = 0, vader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func playSoundButton(_ sender: AnyObject){
        print("sound button pressed!")
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        print("stopButtonPressed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
}
