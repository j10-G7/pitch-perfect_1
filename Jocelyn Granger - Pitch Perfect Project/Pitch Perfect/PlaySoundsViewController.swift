//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jocelyn Granger on 3/31/15.
//  Copyright (c) 2015 Jocelyn Granger. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    var audioPlayerNode : AVAudioPlayerNode!
    var receivedAudio : RecordedAudio!  // contains NSURL to sound file
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set path to audio player object
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        // Must be done before changing rate of audio player speed
        audioPlayer.enableRate = true
        
        // Initialize its value
        audioEngine = AVAudioEngine()
        
        // Initialize audioFile, by using receivedAudio's NSURL
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playSoundFile(in_rate: Float, in_pitch: Float) {
        // Stop playing, before starting to play new file
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0   // Set pointer to beginning of sound file
        audioPlayer.rate = in_rate
        
        // If normal pitch
        if ( in_pitch == 0) {
            audioPlayer.play()
        }
        else {
            playAudioWithVariablePitch(in_pitch)
        }
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playSoundFile(0.5, in_pitch:0)
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        playSoundFile(1.5, in_pitch:0)
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playSoundFile(1.0, in_pitch:1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playSoundFile(1.0, in_pitch:-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)  // start the audio engine
        
        audioPlayerNode.play()  // play the audio player
    }

    
    @IBAction func stopPlaying(sender: UIButton) {
        if (audioPlayerNode != nil) {
            audioPlayerNode.stop()
        }
        
        audioPlayer.stop()
    }
    
}
