//
//  AudioInput.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//

import AudioKit

/// Audio Input configurator
protocol AudioInput {
    /**
     Get current microphone input
     
     - Returns: InputeNode
     */
    func getMicrophone() -> AudioEngine.InputNode
    
    /// Start the AudioEngine
    func startEngine()
    
    /// Stop the AudioEngine
    func stopEngine()
}
