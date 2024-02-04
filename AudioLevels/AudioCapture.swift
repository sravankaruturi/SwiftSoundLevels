//
//  AudioCapture.swift
//  AudioLevels
//
//  Created by Sravan Karuturi on 2/1/24.
//

import Foundation
import AVKit

class AudioCapture {
    
    public static var audioRec: AVAudioRecorder? = nil
    
    public static func setupAudioCapture() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            
            try recordingSession.setCategory(.playAndRecord)
            try recordingSession.setActive(true)
            
            AVAudioApplication.requestRecordPermission { result in
                guard result else {
                    print("Unable to get permission")
                    return
                }
            }
            
        }catch {
            print(error)
        }
        
        captureAudio()
        
    }
    
    public static func captureAudio() {
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = documentPath.appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            
            audioRec = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRec!.record()
            audioRec!.isMeteringEnabled = true
            
        }catch {
            print(error)
        }
        
    }
    
}
