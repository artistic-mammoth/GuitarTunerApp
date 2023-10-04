//
//  AudioInputImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//

import AudioKit
import AudioKitEX
import AVFoundation

/// Implementation of AudioInput
final class AudioInputImpl: HasAudioEngine {
    // MARK: - Public properties
    let engine = AudioEngine()
    
    // MARK: - Private properties
    private let microphone: AudioEngine.InputNode
    private let silence: Fader
    
    // MARK: - Init
    init() {
        // Preparation of AVAudio
        do {
            Settings.bufferLength = .medium
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                            options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error)
        }
        
        // TODO: - Refactor of catching Errors
        // Checking the input for avaiavle
        guard let input = engine.input else { fatalError() }
        
        // Setup devices
        microphone = input
        
        // Disable microphone output
        silence = Fader(microphone, gain: 0)
        engine.output = silence
    }
}

// MARK: - AudioInput
extension AudioInputImpl: AudioInput {
    func getMicrophone() -> AudioEngine.InputNode {
        microphone
    }
    
    func startEngine() {
        start()
    }
    
    func stopEngine() {
        stop()
    }
}
