//
//  RecordViewController.swift
//  pitchGang
//
//  Created by Jameka Echols on 2/13/21.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController , AVAudioRecorderDelegate{

    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI(recoredState: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func recordSound(_ sender: Any) {
        ConfigureUI(recoredState: true)
        
        // setting path for audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopRecordSound(_ sender: Any) {
        ConfigureUI(recoredState: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording was not successful")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC = segue.destination as! PlaySoundsViewController //declare the destination or where the segue // is going and since we know its type which is of viewcontroller we can upcast it using as!
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func ConfigureUI(recoredState: Bool){
        // if record state is true, enable stop button, disable record and change label
        if(recoredState){
            recordButton.isEnabled = false;
            stopButton.isEnabled = true;
            recordLabel.text = "Recording in Progress"
        }else{
            recordButton.isEnabled = true;
            stopButton.isEnabled = false;
            recordLabel.text = "Tap to Record";
        }
    }
    
}

